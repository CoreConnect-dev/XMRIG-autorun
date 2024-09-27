#!/bin/bash

# Variables
XMRIG_VERSION="6.19.3"
POOL_URL="pool.supportxmr.com"
DEFAULT_PORT="3333"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Install dependencies
echo "Installing dependencies..."
apt update && apt install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev

# Clone the XMRig repository
if [ ! -d "xmrig" ]; then
    echo "Cloning XMRig repository..."
    git clone https://github.com/xmrig/xmrig.git
else
    echo "XMRig directory already exists. Pulling the latest changes..."
    cd xmrig
    git pull
    cd ..
fi

# Build XMRig
echo "Building XMRig..."
cd xmrig
mkdir -p build
cd build
cmake ..
make -j$(nproc)
if [ $? -ne 0 ]; then
    echo "Build failed. Please check for errors."
    exit 1
fi

# Get Monero wallet address from user
read -p "Enter your Monero wallet address: " WALLET_ADDRESS
if [ -z "$WALLET_ADDRESS" ]; then
  echo "Monero address cannot be empty."
  exit 1
fi

# Confirm details
echo "Configuration:"
echo "Pool Address: $POOL_URL:$DEFAULT_PORT"
echo "Monero Address: $WALLET_ADDRESS"
echo "Worker Name: $(hostname)"

# Create config.json for XMRig
cat << EOF > config.json
{
  "autosave": true,
  "cpu": {
    "enabled": true,
    "huge-pages": true,
    "hw-aes": null,
    "priority": 5,
    "rx": [1, 0],
    "rx/0": {
      "double-hash": false,
      "jit": true,
      "numa": false,
      "secure-jit": false,
      "wrmsr": false,
      "yield": true
    }
  },
  "pools": [
    {
      "url": "$POOL_URL:$DEFAULT_PORT",
      "user": "$WALLET_ADDRESS",
      "pass": "$(hostname)",
      "keepalive": true,
      "nicehash": false,
      "variant": -1
    }
  ]
}
EOF

# Run XMRig with configuration
echo "Starting XMRig with the given configuration..."
./xmrig -c config.json

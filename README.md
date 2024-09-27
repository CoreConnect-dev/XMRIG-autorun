****XMRig Monero Mining Setup Script****

This script automates the process of setting up and configuring XMRig to mine Monero (XMR) using your Ubuntu system. 
It installs all necessary dependencies, clones the XMRig repository, compiles it, and configures it with your Monero wallet address and preferred mining pool.

Features
**Automated Installation:** Installs all required dependencies and compiles XMRig from source.

**Custom Configuration:** Easily input your Monero wallet address and preferred pool settings.

**Dynamic Build:** Utilizes all available CPU cores for efficient mining.

***Requirements***

Ubuntu system (Tested on Ubuntu 18.04, 20.04)

Root privileges

**Clone the Repository:**

```
git clone https://github.com/yourusername/xmrig-setup-script.git
cd xmrig-setup-script
```

**Run the Script:**

```
sudo ./xmrig-setup.sh
```
**Enter Your Monero Wallet Address:** When prompted, enter your Monero wallet address.

**Mining Configuration:** The script will automatically configure the config.json file with your settings:

Pool Address: pool.supportxmr.com:3333
Worker Name: Your system hostname
Start Mining: After configuration, the script will start XMRig with your custom settings.

***Notes:***
Make sure you have a stable internet connection.

This script is designed for use on Ubuntu systems with root privileges.

Feel free to modify the pool URL and port if you prefer a different mining pool.

If you have any suggestions or improvements, feel free to open an issue or submit a pull request.

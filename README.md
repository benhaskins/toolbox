# Setup Toolbox

## First boot
```bash
wget --output-document /tmp/first_boot.sh "https://raw.githubusercontent.com/benhaskins/toolbox/refs/heads/main/first_boot.sh"
chmod +x /tmp/first_boot.sh
sudo /tmp/first_boot.sh
```

## Setup 1Password for Ubuntu

```bash
mkdir -p ~/code
cd ~/code
git clone https://github.com/benhaskins/toolbox.git
cd ~/code/toolbox
sudo ./setup_1password.sh
```

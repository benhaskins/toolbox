# Setup Toolbox

```bash
wget --output-document /tmp/00_first_boot.sh "https://raw.githubusercontent.com/benhaskins/toolbox/refs/heads/main/00_first_boot.sh"
chmod +x /tmp/00_first_boot.sh
sudo /tmp/00_first_boot.sh
```

```bash
mkdir -p ~/code
cd ~/code
git clone https://github.com/benhaskins/toolbox.git
cd ~/code/toolbox
sudo ./01_setup_1password.sh
```

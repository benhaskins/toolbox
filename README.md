# Setup Toolbox

Ben's minimal machine (ubuntu/debian) bootstrap scripts

## First boot
```bash
wget --output-document /tmp/first_boot.sh "https://raw.githubusercontent.com/benhaskins/toolbox/refs/heads/main/first_boot.sh"
chmod +x /tmp/first_boot.sh
sudo /tmp/first_boot.sh
```

## Setup Things

```bash
export THING=docker
wget --output-document /tmp/setup_1password.sh "https://raw.githubusercontent.com/benhaskins/toolbox/refs/heads/main/setup_${THING}.sh"
chmod +x /tmp/setup_${THING}.sh
sudo /tmp/setup_${THING}.sh
```

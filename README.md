# runner-images

#### Just copy and past
requirements

update
```bash
apt update
```
```bash
apt install software-properties-common --yes
```
install curl
```bash
apt install curl -y
```
install requirements
```bash
curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/NeuralInnovations/runner-images/main/install.sh | bash
```

---

use with sudo
```bash
sudo apt update
sudo apt install software-properties-common --yes
sudo apt install curl -y

sudo curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/NeuralInnovations/runner-images/main/install.sh -o ./image-install.sh 
sudo chmod 777 ./image-install.sh 
sudo ./image-install.sh

sudo usermod -aG docker $USER
```


--- 
#### Manual

1. **copy the 'images' directory to your server**
2. **set permissions** ```chmod -R 777 ./images/linux```
3. **install**
   - **arm64** ```./images/linux/install.sh --arch linux-aarch64```
   - **x86_64** ```./images/linux/install.sh --arch linux-x86_64```

#### help:
```./images/linux/install.sh --help```

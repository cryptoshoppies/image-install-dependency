# runner-images

#### Just copy and past
requirements
```bash
apt update
apt install curl -y
curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/NeuralInnovations/runner-images/main/install.sh -o ./image-install.sh && chmod 777 ./image-install.sh && ./image-install.sh
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
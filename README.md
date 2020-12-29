# Dragonchain Hetzner Guide

Most of the steps are taken unedited from: https://github.com/Dragonchain-Community/dragonchain-uvn-install-guide/blob/master/manual-install.md however some of the steps are modified to be easier to use for beginners.

## Hetzner referall code for 20$ free credits
CODE GOES HERE

## Server setup 

1. Make a required change in sysctl.conf

   ```echo vm.max_map_count=262144 | sudo tee -a /etc/sysctl.conf```

2. Force the change on our live system

   ```sudo sysctl -w vm.max_map_count=262144```

3. Ensure apt is updated and necessary packages are installed

    ```sudo apt update && sudo apt upgrade -y && sudo apt install -y jq openssl xxd snapd```

4. Install microk8s

    ```sudo snap install microk8s --channel=1.18/stable --classic```

5. Alias the kubectl command (if you don’t have normal kubectl installed)
    - If you DO have kubectl already installed (shouldn’t if this is a clean Ubuntu installation), you’ll need to prefix ANY kubectl commands below with “microk8s”, so “microk8s.kubectl get pods -n dragonchain” for example. This should only matter if you already know what you’re doing.

    ```sudo snap alias microk8s.kubectl kubectl```

6. Setup networking stuff (firewall rules)

    ```sudo ufw --force enable && sudo ufw default allow routed && sudo ufw default allow outgoing && sudo ufw allow 22/tcp && sudo ufw allow 30000/tcp && sudo ufw allow in on cni0 && sudo ufw allow out on cni0```

7. Enable microk8s modules

    ```sudo microk8s.enable dns storage helm3```

8. Alias the helm command 

    ```sudo snap alias microk8s.helm3 helm```

9. Install the last microk8s modules

    ```sudo microk8s.enable registry```


## Manual Installation - Dragonchain Installation

1. Create a setup directory (just for organization) and metadata directory

    ```cd ~/ && mkdir setup && cd setup && mkdir metadata```

2. Download the node prep scripts and install script

    ```wget https://raw.githubusercontent.com/Dragonchain-Community/dragonchain-uvn-install-guide/master/resources/node-prep.sh && wget https://raw.githubusercontent.com/parlex/dragonchain-hetzner-guide/main/set-values.sh && https://raw.githubusercontent.com/parlex/dragonchain-hetzner-guide/main/install_dragonchain.sh```

3. Enable execution on scripts

    ```chmod +x ./node-prep.sh ./set-values.sh ./install_dragonchain.sh```

4. Execute the node-prep.sh script

    ```sudo ./node-prep.sh```

7. Run set values script and input values

   ```./set-values.sh```

8. Run the install scriptt:

   ```sudo ./install_dragonchain.sh >> ./metadata/hmac.txt```

9. Repeat step 7 and 8. until you've installed the desired amount of nodes.

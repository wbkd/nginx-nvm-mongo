### Index

- [Requirements](#requirements)
- [Clone](#clone)
- [Configuration](#configuration)
- [Run!](#run)
- [Troubleshooting](#troubleshooting)


This template uses [Packer](https://www.packer.io/) to build a [DigitalOcean](https://digitalocean.com) snapshot running Ubuntu.
Packer will use [Ansible](http://ansible.com/) to provision the machine and perform the following steps:

- add a **new user** and configure **groups**
- enable and configure **sudo**
- enable some opinionated **ssh security settings**
- adding your **ssh key** to the droplet
- enable and configure **ufw firewall**
- set up **zsh** and **oh-my-zsh**
- install and configure **nginx** to serve a static folder and an upstream backend
- install **nvm**, **node.js** and a list of required **npm packages**
- install **mongodb**

Have fun !

### Requirements:

- **[Packer](https://www.packer.io/downloads)>=0.8**

### Clone:
This will clone the repository and its git [dependencies](https://github.com/wbkd/nginx-nvm-mongo/blob/master/ansible/roles)
```
git clone https://github.com/wbkd/nginx-nvm-mongo.git
git submodule init
git submodule update
```

### Configuration

Packer's configuration is in [build.json](https://github.com/wbkd/nginx-nvm-mongo/blob/master/build.json), you must add your **api_token** there or refer to the [Packer Documentation](https://www.packer.io/docs) in order to use other builders.

The Ansible provision script [./ansible/provision.yml](https://github.com/wbkd/nginx-nvm-mongo/blob/master/ansible/provision.yml) has some variables defined at [./ansible/vars.yml](https://github.com/wbkd/nginx-nvm-mongo/blob/master/ansible/vars.yml).

Take a look to the shell variables used in [./run.sh](https://github.com/wbkd/nginx-nvm-mongo/blob/master/run.sh), you may need to adapt this script to your system's requirements.

### Run!

```
./run.sh
```

At the end of the deployment process, you should be able to launch the created droplet from your DigitalOcean panel.
You can log into the droplet via ssh using the user you specified in [./ansible/vars.yml](https://github.com/wbkd/nginx-nvm-mongo/blob/master/ansible/vars.yml).

Place your static files in the folder associated with the variable `nginx_root` and run your application server on the port associated with the variable `node_port`. 

E.g.:
```
echo "<h1> works </h1>" > ~/project/index.html
```
And then open your droplet IP in your browser.

### Troubleshooting

- If errors occur **creating the droplet**, then you should double-check if the installed packer **version is greater than 0.8**.

- You should not upload folders containing **symlinks** or you will run into the [following issue](https://github.com/mitchellh/packer/issues/1627):
 ```
  errored: Error uploading playbook_dir directory
  ```
  That's why `./run.sh` is actually **deleting all symlinks** from the project folder.

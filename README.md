# Scripts
A lot of scripts for daily work and Also, There're some media contents that is about English.


## Resources

* [Phonetic List](./src//english//medias/)
* [750 Oxford Common Phrases](./resources/oxford_common_phrase_list.json)

## git_gpg.sh

Executing `$pwd/src/git_gpg.sh` for more details

## volume.sh
using it on Raspiberry platform



```shell
git clone https://github.com/danielsss/scripts.git
cd scripts/src
sudo chmod +x volume.sh
sudo cp -r volume.sh /usr/local/bin/volume
echo "alias volume='/bin/bash /usr/local/bin/volume'" >> ~/.bashrc
```


## docker_wait.sh
```yml
example:
    container_name: example
    build:
      context: .

    environment:
      NODE_ENV: ${NODE_ENV:-development}
    
    command: sh -c 'scripts/wait.sh server:80 -- node app.js'
```

## Proxy
* proxy.sh
  - set local proxy environments

* unset_proxy.sh
  - unset local proxy environments

## remove_commits.sh
* The violent behavior to remove the commits

```shell
sh remove_commits.sh
```

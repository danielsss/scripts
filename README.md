# Scripts
a lots of scripts for daily work


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
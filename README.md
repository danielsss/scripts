# scripts
a lots of scripts for daily work


## docker.wait.sh
```yml
example:
    container_name: example
    build:
      context: .

    environment:
      NODE_ENV: ${NODE_ENV:-development}
    
    command: sh -c 'scripts/wait.sh server:80 -- node app.js'
```
# pyBanca v0.0

> A webapp for lottery tickets thinking in convergence and heavy loads.

## STACK (wip)

- [Elmlang](http://elm-lang.org/) for the frontend.
- [japronto](https://github.com/squeaky-pl/japronto) as super fast http/request (python 3.5) server.
- SQLAlchemy as ORM.
- MySQL as DB.

## Infrastructure

- We will have a Docker container with Alpine runing our WSGI python backend.
- The backend will serve an `index.html` that calls an `index.js` where our **Elm** app lives.

## CI

- Jenkins
- Travis (more research needed)

### Deployment (pipeline perhaps)

- First, order webpack to compile the elm files and prepare them for production.
- And later, do the **thing**.

### TODO

- config files (thinking in the 12 factor apps)
- chosing IaaS: heroku or google
  - **Hint:** we cab user heroku as our **staging** and google compute engine as **production**.
- Do a stress test: lets see if that of **1.2** millons of *request* are true.

## Environment

- linux :)
- docker
- python 3.5
- virtualenv
- nvm
- nodejs
- webpack

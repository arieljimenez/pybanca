# pyBanca v0.0

> A webapp for lottery tickets thinking in convergence and heavy loads.

## STACK (wip)

- [Elmlang](http://elm-lang.org/) for the frontend.
- [japronto](https://github.com/squeaky-pl/japronto) as super fast http/request (python >= 3.5) server.
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
`
## Environment

- Alpine docker container (with gcc libs)
- python 3.6.3 && 2.7.14: needed for webpack 3 plugnins (updating to webpack 4 will solve this)
- nodejs v8.9.3
- webpack 3.10.0
- elm 0.18

<!-- - virtualenv -->

### TODO

- config files (thinking in the 12 factor apps)
- chosing IaaS: heroku or google
  - **Hint:** we cab user heroku as our **staging** and google compute engine as **production**.
- Do a stress test: lets see if that of **1.2** millons of *request* are true.
- Update Webpack to 4.

### Q/A

- **Q:** _Why ignore the package-lock.json?_
  - **A:** this introduces more conflicts and problems than resolve ([ref](https://stackoverflow.com/questions/44297803/package-lock-json-role)).

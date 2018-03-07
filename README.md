# pyBanca Boilerplate

>Infraestructure behind the app.

## STACK (wip)

- [Elmlang](http://elm-lang.org/) for the frontend.
- [Japronto](https://github.com/squeaky-pl/japronto) for the WSGI/API service.
- SQLAlchemy as ORM.
- MariaDB as RDBMS.

## CI

- Jenkins (EDIT: will have his own container)
- Travis (more research needed)

### Deployment (pipeline perhaps)

- We will have a Docker container with Alpine runing our WSGI python backend.
- The backend will serve an `index.html` that calls an `index.js` where our **Elm** app lives.
- First, give the webpack order to compile the elm files and prepare them for production.
- And later, do the **thing**.

## Environment

- Alpine docker container (with gcc libs)
- python 3.6.3 && 2.7.14: needed for webpack 3 plugnins (updating to webpack 4 will solve this)
- nodejs v8.9.3
- webpack 3.10.0
- elm 0.18
- mariadb

## Dev dependencies

- Linux :^)
- [Docker](https://github.com/arieljimenez/configx/blob/Elementary/apps/docker.sh)
- Some visual database modeler, like [MySQL Workbench](https://www.mysql.com/products/workbench/).
- A text editor: VS Code, Vim, Sublime or Atom. (yes, ordered by likeness).
- A terminal (_with zsh perhaps?_)
- Good intentions :)

### TODO

- Config files (thinking in the 12 factor apps).
- Chosing IaaS: heroku or google.
  - **Hint:** we cab user heroku as our **staging** and google compute engine as **production**.
- Do a stress test: lets see if that of **1.2** millons of *request* are true.
- Update Webpack to 4.
- Facture the stack in microservices.

### Q/A

- **Q:** _Why ignore the package-lock.json?_
  - **A:** this introduces more conflicts and problems than resolve ([ref](https://stackoverflow.com/questions/44297803/package-lock-json-role)).

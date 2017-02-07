Using Docker on OS X/macOS
==========================

Using Docker for our local development brings much joy to life. It means that your development environment is always consistent and less susceptible to local machine misconfigurations and other hassles. It bundles all of the requirements for running spokesman.com into a neat little package, so there's no need to install postgresql/memcached/redis/rabbitmq/gdal or any of the other things that are a pain in the behind to install and maintain properly.
Installing Docker

Install brew (on OSX > 10.8, it automatically installs XCODE commandline tools)

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install brew services, virtualbox, docker, docker-compose, docker-machine, initialize

```
brew tap homebrew/services
brew cask install virtualbox
brew install docker docker-compose docker-machine
brew services start docker-machine
docker-machine create --driver virtualbox default
```

Create local working directory
```
mkdir -p ~/code/ && cd ~/code/
```

Checkout repository and copy config files from repo Note: Will need credentials from IT to access Subversion/Git? repo

```
git https://github.com/python-spokane/python-docker-compose.git

```

Add Docker startup script to .bash_profile

```
echo "
#Docker
DOCKER_MACHINE="default"
if docker-machine status $DOCKER_MACHINE | grep "Running" &> /dev/null
  then
    eval "$(docker-machine env $DOCKER_MACHINE)"
  else
    docker-machine start $DOCKER_MACHINE && eval "$(docker-machine env $DOCKER_MACHINE)"
fi
" >> ~/.bash_profile
```

Source your .bash_profile to initialize Docker

```
source ~/.bash_profile
```

Build and run
-------------

```
docker-compose up
```

Once the Docker containers are built, open running server in browser
```
open http://$(docker-machine ip):8000
```

Using Docker
------------

There are a handful of commands you'll want to run (all commands assume you have $ cd ~/code/python-docker-compose/ into the directory:

Starting Docker:

```
$ docker-compose up
```

Stopping Docker:

```
Ctrl+C
```

To switch between the staging DB and the live DB, change the USE_LIVE_DB config variable in docker-compose.yml to either 0 or 1 and restart Docker.

To add or update a Python Package to Django, add your changes to ~/code/python-docker-compose/requirements.txt then:

```
$ docker-compose build web
```

To use the command line within the Docker container:
```
$ docker-compose run web bash
```

To use a management command from within the Docker container:

```
$ docker-compose run web django-admin.py <command>
```

To start an iPython Notebook environment within the Docker container:

```
$ docker-compose run --service-ports web bash
$ django-admin.py shell_plus --notebook
# in new terminal
$ open http://$(docker-machine ip):8889/tree/repo/bin/notebooks
```

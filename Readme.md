##Getting Started

Before beginning you'll need Vagrant and Virtualbox installed.

Add the following entry in your /etc/hosts file:

```
33.33.33.60	railsgoat.dev
```

Change into DoctorDocker directory, use this command to start via Vagrant:

```
$ vagrant up --no-parallel
```

You can start individual docker contaniners with the folloing:

```
$ vagrant up db
$ vagrant up web
```

To ssh into the docker proxy VM:

```
$ vagrant global-status 

$ vagrant ssh [id of vm]
```
To enter into a docker container with docker-enter run the following command from inside the vagrant proxy box
This will install nsenter and docker-enter onto the proxy box

```
$ curl https://gist.githubusercontent.com/lox/d210a74d3c2f317786ab/raw/install-nsenter.sh | bash
```


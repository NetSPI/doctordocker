##Getting Started

Before beginning you'll need Vagrant and Virtualbox installed.

Add the following entry in your /etc/hosts file:

```
33.33.33.60	railsgoat.dev kibana.dev
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
$ curl https://gist.githubusercontent.com/pjcoole/45a7202c7f91335e8b13/raw/e1440bf4cf809f5d99fe516a96ac75a84d53967c/install-nsenter.sh | bash
```


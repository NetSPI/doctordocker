##Getting Started

Before beginning you'll need Vagrant and Virtualbox installed.

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


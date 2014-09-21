

VAGRANTFILE_API_VERSION = "2"
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "nginxproxy" do |nginxproxy|
    nginxproxy.vm.provider "docker" do |d|
      d.image = "pjcoole/nginx:auto"
      d.name = "nginxproxy"
      d.ports = ["8080:80"]
      d.volumes = ["/var/run/docker.sock:/tmp/docker.sock"]
      d.create_args = ["-t"]
      d.vagrant_vagrantfile = "./Vagrantfile.proxy"
    end
  end

  config.vm.define "db" do |db|
    db.vm.provider "docker" do |d|
      d.image = "mysql"
      d.name = "db"
      d.expose = [3306]
      d.env = {MYSQL_USER: "root", MYSQL_PASS: "docker", MYSQL_ROOT_PASSWORD: "docker"}
      d.vagrant_vagrantfile = "./Vagrantfile.proxy"
    end
  end

  config.vm.define "web1" do |web1|
    web1.vm.provider "docker" do |d|
      d.image = "pjcoole/railsgoat"
      d.name = "web1"
      d.link("db:dockerdb")
      d.expose = [3000]
      d.env = {VIRTUAL_HOST: "railsgoat.dev"}
      d.vagrant_vagrantfile = "./Vagrantfile.proxy"
    end
  end

  config.vm.define "web2" do |web2|
    web2.vm.provider "docker" do |d|
      d.image = "pjcoole/railsgoat"
      d.name = "web2"
      d.link("db:dockerdb")
      d.expose = [3000]
      d.env = {VIRTUAL_HOST: "railsgoat.dev"}
      d.vagrant_vagrantfile = "./Vagrantfile.proxy"
    end
  end

end

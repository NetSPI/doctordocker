VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "db" do |db|
    db.vm.provider "docker" do |d|
      d.image = "mysql"
      d.name = "db"
      d.expose = [3306]
      d.env = {MYSQL_USER: "root", MYSQL_PASS: "docker", MYSQL_ROOT_PASSWORD: "docker"}
      d.vagrant_vagrantfile = "./Vagrantfile.proxy"
    end
  end

  config.vm.define "web" do |web|
    web.vm.provider "docker" do |d|
      d.image = "pjcoole/railsgoat"
      d.name = "web"
      d.link("db:dockerdb")
      d.ports = ["3000:3000"]
      d.vagrant_vagrantfile = "./Vagrantfile.proxy"
    end
  end

end

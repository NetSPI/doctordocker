module DockerControl
	Docker.url = 'tcp://192.168.59.103:2375'

	def swap
		containers = old_containers

		cont = Docker::Container.create('Image' => 'pjcoole/railsgoat')
		cont.start("Links" => ["db:dockerdb"], 'PublishAllPorts' => true)

		unless containers.nil?
			containers.each do |container|
				container.stop && container.delete(:force => true)
			end
		end
	end

	def old_containers
		Docker::Container.all.select {|x|  x.info["Image"] == "pjcoole/railsgoat:latest"}
	end
end

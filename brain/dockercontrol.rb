module DockerControl
	Docker.url = 'tcp://192.168.59.103:2375'

	def swap
		containers = current_containers
		image  = create_image

		cont = create_container(image.info["id"])
		cont.start("Links" => ["db:dockerdb"], 'PublishAllPorts' => true)

		unless containers.nil?
			containers.each do |container|
				container.stop && container.delete(:force => true)
			end
		end
	end

	def current_containers
		Docker::Container.all.select {|x|  x.info["Image"] == "pjcoole/railsgoat:latest"}
	end

	def create_image
		Docker::Image.create("fromImage" => "pjcoole/railsgoat")
	end

	def create_container(id)
		Docker::Container.create("Image" => "#{id}")
	end
end

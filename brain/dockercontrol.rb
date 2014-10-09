module DockerControl
	Docker.url = 'tcp://192.168.59.103:2375'

	def swap
		puts 'Starting container swap'
		#get list of current containers
		containers = current_containers

		puts 'Pulling down and creating new image...'
		#create new image and pull down new image from docker hub
		image  = create_image

		puts "New image created with ID: #{image.id}"

		puts 'Creating new container...'
		#create container from new image
		container = create_container(image)

		puts 'Starting new container...'
		#start new container
		start_container(container)

		puts 'Removing old containers'
		#clean up old containers
		remove_containers(containers)

	end

	private

	def start_container(container)
		container.start("Links" => ["db:dockerdb"], 'PublishAllPorts' => true)
	end

	def current_containers
		Docker::Container.all.select {|x|  x.info["Image"] == "pjcoole/railsgoat:latest"}
	end

	def create_image
		Docker::Image.create("fromImage" => "pjcoole/railsgoat")
	end

	def create_container(image)
		Docker::Container.create("Image" => "#{image.info["id"]}")
	end

	def remove_containers(containers)
		unless containers.nil?
			containers.each do |container|
				container.stop && container.delete(:force => true)
			end
		end
	end

end

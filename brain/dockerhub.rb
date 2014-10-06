module DockerHub

	URL = "https://registry.hub.docker.com/u/pjcoole/railsgoat/trigger/9fe1e2bc-4c11-11e4-97b5-cafcd57b5e39/"

	#curl --data "build=true" -X POST https://registry.hub.docker.com/u/pjcoole/railsgoat/trigger/9fe1e2bc-4c11-11e4-97b5-cafcd57b5e39/
	def rebuild
		response = HTTParty.post(
			URL,
			{
				:body => { :build => 'true'}
		})
		return response
	end

	def current_build
		response = HTTParty.get("https://registry.hub.docker.com/v1/repositories/pjcoole/railsgoat/tags")
		response.parsed_response.first["layer"]
	end

	def old_build?(current)
		response = HTTParty.get("https://registry.hub.docker.com/v1/repositories/pjcoole/railsgoat/tags")
		layer = response.parsed_response.first["layer"]
		layer == current[0..7]
	end
end
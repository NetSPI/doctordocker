#!/usr/bin/env ruby

require 'pp'
require 'json'
require 'fileutils'
require 'httparty'
require 'docker'
include DoctorHub
include DockerControl

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

module DockerControl
	Docker.url = 'tcp://192.168.59.103:2375'

	def swap
		old_containers = old_containers

		cont = Docker::Container.create('Image' => 'pjcoole/railsgoat')
		cont.start("Links" => ["db:dockerdb"], 'PublishAllPorts' => true)

		old_containers.each do |container|
			container.stop && container.delete(:force => true)
		end
	end

	def old_containers
		Docker::Container.all.select {|x|  x.info["Image"] == "pjcoole/railsgoat:latest"}
	end
end

module DoctorDocker
	class Check

		def check
			`bundle-audit --ignore_sources`
			if $?.exitstatus
				puts 'Vulnerabilities in Gems!'
				true
			else
				puts 'No Vulnerabilities in Gems!'
				false
			end
		end

		if check
			puts "Starting new build..."
			@current_build = current_build
			puts "Current build:" + @current_build

			#build_result = dock.rebuild


			if true #build_result.chomp == "OK"
				puts "Build result: " + build_result

				while  false #dock.old_build?(@current_build)
					puts 'Sleeping for 60 seconds.. '
					sleep 60
				end
				swap
				puts "Succussfully swapped"
			else
				puts "Build result: " + build_result
				puts 'Build trigger failed'
				exit 1
			end
		end
	end
end

checker = DoctorDocker::Check.new

checker.check

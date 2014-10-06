#!/usr/bin/env ruby

$LOAD_PATH << '.'

require 'pp'
require 'json'
require 'fileutils'
require 'httparty'
require 'docker'
require 'dockerhub'
require 'dockercontrol'


module DoctorDocker
	class Check
	include DockerHub
	include DockerControl

		def check
			`bundle-audit` #--ignore_sources`
			if $?.exitstatus == 1
				puts 'Vulnerabilities in Gems!'
				true
			else
				puts 'No Vulnerabilities in Gems!'
				false
			end
		end

		def run
			if check
				puts "Starting new build..."
				@current_build = current_build
				puts "Current build:" + @current_build

				build_result = rebuild

				if build_result.chomp == "OK"
					puts "Build result: " + build_result

					while  old_build?(@current_build)
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
			else
				puts 'DoctorDocker exiting..'
			end
		end
	end
end

checker = DoctorDocker::Check.new

checker.run

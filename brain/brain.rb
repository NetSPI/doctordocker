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
				
				@current_build = current_build
				puts "Current build:" + @current_build

				puts "Starting new build..."
				build_result = rebuild
				timer = 0
				if build_result.chomp == "OK"
					puts "Build result: " + build_result
					puts "Waiting for build to complete.."
					while  old_build?(@current_build)
						sleep 1
						print "\rElapsed time: #{timer.to_s} seconds"
						timer += 1
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

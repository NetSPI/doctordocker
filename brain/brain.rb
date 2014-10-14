#!/usr/bin/env ruby

$LOAD_PATH << '.'

require 'pp'
require 'json'
require 'fileutils'
require 'httparty'
require 'fileutils'
require 'docker'
require 'dockerhub'
require 'dockercontrol'


module DoctorDocker
	class Check
	include DockerHub
	include DockerControl

	WORKING_DIR='./tmp'
	GEMFILE_PATH="/usr/src/app/Gemfile.lock"

		def run
			if check(WORKING_DIR)

				@current_build = current_build
				puts "Current build:" + @current_build

				puts "Starting new build..."
				build_result = rebuild
				timer = 0
				if build_result.chomp == "OK"
					puts "Build kickoff: " + build_result
					puts "Waiting for build to complete.."
					while  old_build?(@current_build)
						sleep 1
						print "\rElapsed time: #{timer.to_s} seconds"
						timer += 1
					end
					swap
				else
					puts "Build result: " + build_result
					puts 'Build trigger failed'
					exit 1
				end
			else
				puts 'DoctorDocker exiting..'
			end
		end

		private

		def copy_file(container, file, outdir)
			string = ''
			puts 'copying Gemfile.lock from app container..'
			container.copy(file) {|chunk| string.concat(chunk)}
			unpack_tar(outdir, string)
		end

		def unpack_tar(directory, string)
			puts 'unpacking Gemfile.lock..'
		  FileUtils.mkdir_p(directory) if !File.exist?(directory)
		  stringio = StringIO.new(string)
		  input = Archive::Tar::Minitar::Input.new(stringio)
		  input.each {|entry| input.extract_entry(directory, entry)}
		end

		def check(directory)
			puts 'Starting vunlerability check..'
			copy_file(current_containers.first, GEMFILE_PATH, WORKING_DIR)
			`cd #{WORKING_DIR} && bundle-audit` #--json`
			if $?.exitstatus == 1
				puts 'Vulnerabilities in Gems!'
				true
			else
				puts 'No Vulnerabilities in Gems!'
				false
			end
		end
	end
end

checker = DoctorDocker::Check.new

checker.run

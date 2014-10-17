#!/usr/bin/env ruby

$LOAD_PATH << '.'

require 'pp'
require 'git'
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

		ROOT_DIR = Dir.pwd
		WORKING_DIR='work'
		GOAT_DIR='railsgoat'
		GEMFILE = Dir.pwd+'/'+GOAT_DIR+'/'+'Gemfile'
		GEMFILE_LOCK_PATH="/usr/src/app/Gemfile.lock"

		def initialize
			copy_file(current_containers.first, GEMFILE_LOCK_PATH, WORKING_DIR)
		end

		def run
			if results = check(WORKING_DIR)
				update_code
				process_json(results)
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
			puts "Copying #{file} to #{outdir}"
			string = ""
			container.copy(file) {|chunk| string.concat(chunk)}
			unpack_tar(outdir, string)
		end

		def unpack_tar(directory, string)
			FileUtils.mkdir_p(directory) if !File.exist?(directory)
			stringio = StringIO.new(string)
			input = Archive::Tar::Minitar::Input.new(stringio)
			input.each {|entry| input.extract_entry(directory, entry)}
		end

		def check(directory)

			gem_json = JSON.parse `cd #{WORKING_DIR} && bundle-audit --json`

			if $?.exitstatus == 1
				puts 'Vulnerabilities in Gems!'
				gem_json
			else
				puts 'No Vulnerabilities in Gems!'
				false
			end
		end

		def process_json(json)
			json.each do |gem|
				IO.write(GEMFILE, File.open(GEMFILE) {|f| f.read.gsub(/.*gem["name"].*/, gem_builder(gem))})
			end
		end

		def gem_builder(gem)
			"gem, #{gem['name']}, #{gem['fixed_version']}"
		end

		def update_code
			puts 'Updating code...'
			@g = Git.open(Dir.pwd + '/railsgoat')
			@g.pull
		end
	end
end

checker = DoctorDocker::Check.new

checker.run

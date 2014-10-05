#!/usr/bin/env ruby

require 'docker'
Docker.version

Docker::Container.create('Cmd' => ['ls'], 'Image' => 'base')

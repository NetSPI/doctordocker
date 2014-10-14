# -*- encoding: utf-8 -*-
# stub: docker-api 1.13.6 ruby lib

Gem::Specification.new do |s|
  s.name = "docker-api"
  s.version = "1.13.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Swipely, Inc."]
  s.date = "2014-10-02"
  s.description = "A simple REST client for the Docker Remote API"
  s.email = ["tomhulihan@swipely.com", "bright@swipely.com", "toddlunter@swipely.com"]
  s.homepage = "https://github.com/swipely/docker-api"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "A simple REST client for the Docker Remote API"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<excon>, [">= 0.38.0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<archive-tar-minitar>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<rspec-its>, [">= 0"])
      s.add_development_dependency(%q<cane>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<vcr>, [">= 2.7.0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
    else
      s.add_dependency(%q<excon>, [">= 0.38.0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<archive-tar-minitar>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<rspec-its>, [">= 0"])
      s.add_dependency(%q<cane>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<vcr>, [">= 2.7.0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
    end
  else
    s.add_dependency(%q<excon>, [">= 0.38.0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<archive-tar-minitar>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<rspec-its>, [">= 0"])
    s.add_dependency(%q<cane>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<vcr>, [">= 2.7.0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
  end
end

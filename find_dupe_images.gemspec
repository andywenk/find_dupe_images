# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'find_dupe_images/version'

Gem::Specification.new do |spec|
  spec.name          = "find_dupe_images"
  spec.version       = FindDupeImages::VERSION
  spec.authors       = ["Andy Wenk"]
  spec.email         = ["andy@nms.de"]

  spec.summary       = %q{Find duplicate images in a directory structure}
  spec.description   = %q{Find duplicate images in a directory structure}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rmagick"
  spec.add_dependency "logstash-logger"
  spec.add_dependency "mime-types", "2.99"

  if `man libmagic`.size > 0
    spec.add_dependency "ruby-filemagic"
  else
    spec.post_install_message = "MISSING library - Please install libmagic!"
  end

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end

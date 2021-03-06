# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'find_dupe_images/version'

Gem::Specification.new do |spec|
  spec.name          = "find_dupe_images"
  spec.version       = FindDupeImages::VERSION
  spec.authors       = ["Andy Wenk"]
  spec.email         = ["andy@nms.de"]
  spec.license       = 'Apache 2.0'

  spec.summary       = %q{Find duplicate images in a directory structure}
  spec.description   = %q{Find duplicate images in a directory structure}
  spec.homepage      = "https://github.com/andywenk/find_dupe_images"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rmagick"
  spec.add_dependency "logstash-logger"

  if `man libmagic`.size > 0
    spec.add_dependency "ruby-filemagic"
  else
    raise "\n\nMISSING library - Please install libmagic!\n\n\tMac OS X: brew install libmagic\n\tLinux: see http://blackwinter.github.io/ruby-filemagic/#label-Installation\n\n"
  end

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end

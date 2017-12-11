# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "oauth2_dingtalk/version"

Gem::Specification.new do |spec|
  spec.name          = "oauth2_dingtalk"
  spec.version       = Oauth2Dingtalk::VERSION
  spec.authors       = %w[liukun]
  spec.email         = %w[fee1mix@163.com]

  spec.summary       = 'Omniauth strategy for Dingding(alibaba)'
  spec.description   = 'Using OAuth2 to authenticate dingding user when web resources being viewed within dingding(alibaba) client.'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency 'omniauth', '~> 1.0'
  spec.add_dependency 'omniauth-oauth2', '~> 1.0'
end

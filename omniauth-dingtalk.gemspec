lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth_dingtalk/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-dingtalk'
  spec.version       = OmniauthDingtalk::VERSION
  spec.authors       = %w[liukun]
  spec.email         = %w[fee1mix@163.com]
  spec.homepage      = 'https://github.com/liukun-lk/omniauth-dingtalk'
  spec.license       = 'MIT'

  spec.summary       = 'Omniauth strategy for DingTalk(Alibaba)'
  spec.description   = 'Wrapper the DingTalk Oauth2 API'

  spec.files         = `git ls-files`.split('\n').reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.55'

  spec.add_dependency 'omniauth', '~> 2.0'
  spec.add_dependency 'omniauth-oauth2', '~> 1.7.1'
  spec.add_dependency 'useragent', '~> 0.16'

  spec.add_runtime_dependency 'zeitwerk', '>= 1.3'
end

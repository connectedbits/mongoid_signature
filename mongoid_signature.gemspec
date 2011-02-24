Gem::Specification.new do |s|
  s.name        = "mongoid_signature"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Connected Bits"]
  s.email       = ["info@connectedbits.com"]
  s.homepage    = "http://github.com/connectedbits/mongoid_signature"
  s.summary     = %q{Sign mongoid documents to prevent dupes}
  s.description = %q{Makes it easy to sign Mongoid documents based on a subset of fields to prevent duplicate documents.}

  s.rubyforge_project = "mongoid_signature"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_runtime_dependency('mongoid', ['>= 2.0.0.rc.7'])
  s.add_runtime_dependency('rspec')
end
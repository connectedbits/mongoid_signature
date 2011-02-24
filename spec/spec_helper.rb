require 'rubygems'
require 'bundler'
Bundler.setup

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

MODELS = File.join(File.dirname(__FILE__), "models")
$LOAD_PATH.unshift(MODELS)

require 'mongoid'
require 'mongoid_signature'
require 'rspec'

Mongoid.configure do |config|
  name = "mongoid_signature_test"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
end

Dir[ File.join(MODELS, "*.rb") ].sort.each { |file| require File.basename(file) }

RSpec.configure do |config|
end
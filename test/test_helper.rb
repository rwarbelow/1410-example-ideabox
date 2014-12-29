ENV["RACK_ENV"] = "test"

require 'bundler'
Bundler.require
require 'minitest/autorun'
require 'minitest/pride'
$:.unshift File.expand_path("../../lib", __FILE__)


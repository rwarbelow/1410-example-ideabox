# ENV['RACK_ENV'] = 'test'
# require 'minitest/autorun'
# require 'rack/test'
# require 'sinatra'

# require File.expand_path('../../lib/app', __FILE__)


require 'bundler'
Bundler.require
require 'minitest/autorun'
require 'minitest/pride'
$:.unshift File.expand_path("../../lib", __FILE__)


require 'rubygems'
require 'sinatra'
require 'kramdown'
require 'grit'
require 'digest'
require File.expand_path(File.dirname(__FILE__)) + '/lib/Grities'

controllers = Dir.glob("app/controller/*.rb") 

controllers.each do |controller|
  require "#{File.expand_path(File.dirname(__FILE__))}/#{controller}"
end

map('/') do
  run BaseController
end

map('/wiki') do 
  run WikiController
end


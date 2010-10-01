require('rubygems')
require('sinatra')
require('grit')
require('grities')
require('kramdown')
require('digest')

controllers = Dir.glob("app/controller/*.rb") 

controllers.each do |controller|
  require(controller)
end

map('/') do
  run BaseController
end

map('/wiki') do 
  run WikiController
end


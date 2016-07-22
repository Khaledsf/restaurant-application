APP_ROOT = File.dirname(__FILE__)
$:.unshift(File.join(APP_ROOT, 'lib'))

require 'guide'
obj = Guide.new("restaurant.txt")
obj.launch!
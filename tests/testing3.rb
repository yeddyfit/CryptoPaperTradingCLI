require_relative './testing.rb'

port2 = Portfolio.new("Jacob", "King")
port3 = Portfolio.new("King", "Jacob")

ports = []
ports.push(port2)
ports.push(port3)
File.open('txt.dump', 'w') { |f| f.write(Marshal.dump(ports)) }
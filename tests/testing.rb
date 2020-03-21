# require 'httparty'


# url = "https://api.btcmarkets.net/v2/market/active"
# data_hash = HTTParty.get(url).parsed_response
# data_hash.each do |item|
#     puts item
# end

# File.open("text.txt", "a") do |line|
#     line.puts "\r" + "chill chico"
# end

# File.open("text.txt").each do |line|
#     puts line
# end


class Portfolio
    attr_accessor :user, :pass, :balance, :holdings
    def initialize(user, pass = "")
        @user = user
        @pass = pass
        @balance = 5000
        @holdings = {
            "eth"=> 0,
            "btc" => 0,
            "ltc" => 0
            }
    end
end

### NOTE: Moved to "testing3.rb"
# port2 = Portfolio.new("Jacob", "King")
# port3 = Portfolio.new("King", "Jacob")

# ports = []
# ports.push(port2)
# ports.push(port3)
# File.open('txt.dump', 'w') { |f| f.write(Marshal.dump(ports)) }




# Port = Struct.new(:user, :pass, :balance, :holdings)
# port2 = Port.new("Jacob", "King", 2000,  {"eth"=> 0, "btc" => 0,"ltc" => 0})
# port3 = Port.new("King", "Jacob", 5000, {"eth"=> 0, "btc" => 0,"ltc" => 0})
# ports.push(Marshal.dump(port2))

# File.open("text.txt", "w") { |line| line.puts Marshal.dump(ports) }
# File.write("text.rb", Marshal.dump(ports))
# File.open("text.dump", ports)
### NOTE: 'w+' = read/write to new file. reduce file to zero bytes


# tempPort = Marshal.dump(port2)
# port3 = Marshal.load(tempPort)
# puts port3.user









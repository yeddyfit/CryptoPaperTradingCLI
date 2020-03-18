require 'httparty'
require 'tty-prompt'
require 'terminal-table'

### utilises btcmarkets data api, fetching and parsing SJON data
urls = {
"btcUrl" => 'https://api.btcmarkets.net/market/BTC/AUD/tick',
"ethUrl" => 'https://api.btcmarkets.net/market/ETH/AUD/tick',
"ltcUrl" => 'https://api.btcmarkets.net/market/LTC/AUD/tick'
}
menuOptions = ["lastPrice", "volume24h", "bestBid", "bestAsk", "low24h", "high24h"]
currencies = ["BTC", "ETH", "LTC"]

# select chosen currency 
puts `clear`
prompt = TTY::Prompt.new
curr = prompt.select("Choose Currency", currencies)
url = nil
case curr
when "BTC"
    url = urls["btcUrl"]
when "ETH"
    url = urls["ethUrl"]
when "LTC"
    url = urls["ltcUrl"]
end

# fetch and parse data
data_hash = HTTParty.get(url).parsed_response
# create and print table of parsed data
rows = []
menuOptions.each do |option| 
    rows << [option, data_hash[option]]
end

table = Terminal::Table.new :rows => rows
puts table



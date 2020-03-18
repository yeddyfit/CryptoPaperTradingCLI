require 'json'
require 'httparty'
require 'tty-prompt'
# require 'net/http'

btcUrl = 'https://api.btcmarkets.net/market/BTC/AUD/tick'
ethUrl = 'https://api.btcmarkets.net/market/ETH/AUD/tick'
ltcUrl = 'https://api.btcmarkets.net/market/LTC/AUD/tick'


options = ["lastPrice", "volume24h", "bestBid", "bestAsk", "low24h", "high24h"]
currencies = [BTC, ETH, LTC]


url = ethUrl
uri = URI(url)

# url = "https://api.btcmarkets.net/v2/market/active"
# uri = URI(url)

# response = Net::HTTP.get(uri)

data_hash = JSON.parse(response)

puts data_hash["lastPrice"]
# puts data_hash

prompt = TTY::Prompt.new
curr = prompt.select("Choose Currency\n", currencies)
case curr
when "BTC"
    url = btcUrl
when "ETH"
    url = ethUrl
when "LTC"
    url = ltcUrl
end

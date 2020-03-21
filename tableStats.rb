require_relative './paperTrading.rb'
require_relative './users.rb'

### https://github.com/BTCMarkets/API/wiki/Market-data-API
### utilises btcmarkets data api, fetching and parsing SJON data
### to display stats about a particular currency pairing. 8
# NOTE1: remove APIs if made public
# NOTE2: can be extended by comparing prices with other market data,
#        and notifying (w/ gem) about arbitrage oppurtunities. 

$currStats = ["lastPrice", "volume24h", "bestBid", "bestAsk", "low24h", "high24h"]

def putsTable(url) 
    # fetch and parse data
    data_hash = HTTParty.get(url).parsed_response
    # create and print table of parsed data
    rows = []
    $currStats.each do |option| 
        rows << [option, data_hash[option]]
    end
    table = Terminal::Table.new :rows => rows
    puts table
    
    menuChoice()
end

def statMenu() 
    curr = $prompt.select(" Choose Currency", $currencies)
    case curr
    when "BTC"
        putsTable($urls["BTC"])
    when "ETH"
        putsTable($urls["ETH"])
    when "LTC"
        putsTable($urls["LTC"])
    when "ETH(btc)"
        putsTable($urls["eth(btc)Url"])
    when "LTC(btc)"
        putsTable($urls["ltc(btc)Url"])
    end
end
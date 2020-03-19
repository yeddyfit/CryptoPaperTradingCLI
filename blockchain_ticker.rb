require 'httparty'
require 'tty-prompt'
require 'terminal-table'

### https://github.com/BTCMarkets/API/wiki/Market-data-API

### utilises btcmarkets data api, fetching and parsing SJON data
# NOTE1: remove APIs if made public
# NOTE2: can be extended by comparing prices with other market data,
#        and notifying (w/ gem) about arbitrage oppurtunities.         

$urls = {
"btcUrl" => 'https://api.btcmarkets.net/market/BTC/AUD/tick',
"ethUrl" => 'https://api.btcmarkets.net/market/ETH/AUD/tick',
"ltcUrl" => 'https://api.btcmarkets.net/market/LTC/AUD/tick',
"eth(btc)Url" => 'https://api.btcmarkets.net/market/ETH/BTC/tick',
"ltc(btc)Url" => 'https://api.btcmarkets.net/market/LTC/BTC/tick'
}
$menuOptions = ["lastPrice", "volume24h", "bestBid", "bestAsk", "low24h", "high24h"]
$currencies = ["BTC", "ETH", "LTC", "ETH(btc)", "LTC(btc)", "Triangular Arbitrage?"]


def triArbitrage
    ltcBtcPrice = getPrice("ltc(btc)Url", "bid")
    ethBtcPrice = getPrice("eth(btc)Url", "bid")
    ltcBtcPrice = getPrice("ltc(btc)Url", "ask")
    ethBtcPrice = getPrice("eth(btc)Url", "ask")

    puts ltcBtcPrice
end

def getPrice(curr, bidOrAsk = nil)
    if bidOrAsk == "bid" 
        return HTTParty.get($urls[curr]).parsed_response[$menuOptions[2]]
    elsif bidOrAsk == "ask" 
        return HTTParty.get($urls[curr]).parsed_response[$menuOptions[3]]
    else 
        abort("### Aborted; wrong bidOrAsk argument given to getPrice() ###")
    end
end

def putsTable(url) 
    # fetch and parse data
    data_hash = HTTParty.get(url).parsed_response
    # create and print table of parsed data
    rows = []
    $menuOptions.each do |option| 
        rows << [option, data_hash[option]]
    end

    table = Terminal::Table.new :rows => rows
    puts table
end



# select chosen currency 
puts `clear`
prompt = TTY::Prompt.new
curr = prompt.select("Choose Currency", $currencies)
$url = nil
case curr
when "BTC"
    putsTable($urls["btcUrl"])
when "ETH"
    putsTable($urls["ethUrl"])
when "LTC"
    putsTable($urls["ltcUrl"])
when "ETH(btc)"
    putsTable($urls["eth(btc)Url"])
when "LTC(btc)"
    putsTable($urls["ltc(btc)Url"])
when "Triangular Arbitrage?"
    triArbitrage();
end












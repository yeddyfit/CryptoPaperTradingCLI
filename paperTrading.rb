#### Paper trading CLI that uses BC exchange API price data
#### utilises btcmarkets data api, fetching and parsing SJON data
#### https://github.com/BTCMarkets/API/wiki/Market-data-API
# NOTE1: remove APIs if made public
# NOTE2: can be extended by comparing prices with other market data,
#        and notifying (w/ gem) about arbitrage oppurtunities.    


require_relative './users.rb'
require_relative './tableStats.rb'

$urls = {
    # could replace this w/ an interpolation function replacing the value (scales better)
    "BTC" => 'https://api.btcmarkets.net/market/BTC/AUD/tick',
    "ETH" => 'https://api.btcmarkets.net/market/ETH/AUD/tick',
    "LTC" => 'https://api.btcmarkets.net/market/LTC/AUD/tick',
    "eth(btc)Url" => 'https://api.btcmarkets.net/market/ETH/BTC/tick',
    "ltc(btc)Url" => 'https://api.btcmarkets.net/market/LTC/BTC/tick'
    }
$priceData = ["lastPrice", "volume24h", "bestBid", "bestAsk", "low24h", "high24h"]
$currencies = ["BTC", "ETH", "LTC", "ETH(btc)", "LTC(btc)"]
$menuOptions = ["Display Balances", "Buy Currencies", "Sell Currencies", "Currency Stats", "Back to User Menu"]


def menuChoice()
    puts
    prompt = TTY::Prompt.new
    option = prompt.select("  Whatchu wanna do homebreezy? ", $menuOptions)
    case option
    when $menuOptions[0]
        displayBalances()
    when $menuOptions[1]
        curr = prompt.select("  Which currency bruh?", %w(ETH BTC LTC))
        amount = prompt.ask("  You have $#{$port.cash}, much do you want to spend? ")
        buyCurr(amount, curr)
    when $menuOptions[2]
        curr = prompt.select("  Which currency bruh?", %w(ETH BTC LTC))
        amount = prompt.ask("  You have #{$port.holdings[curr]}, how much do you want to sell? ")
        sellCurr(amount, curr)
    when $menuOptions[3]
        statMenu()
    when $menuOptions[4]
        userMenu()
    end
    puts "chur"
end


def getPrice(curr, bidOrAsk = nil)
    if bidOrAsk == "bid" 
        return HTTParty.get($urls[curr]).parsed_response[$priceData[2]]
    elsif bidOrAsk == "ask" 
        return HTTParty.get($urls[curr]).parsed_response[$priceData[3]]
    else 
        abort("### Aborted; wrong bidOrAsk argument given to getPrice() ###")
    end
end



def displayBalances()
    puts " " + $port.cash
    puts " " + $port.holdings

    menuChoice()
end

def buyCurr(amount, curr)
    price = getPrice(curr, "bid").round(2)
    amount = amount.to_i

    if amount <= $port.cash
        $port.holdings[curr] += (amount/price).round(4)
        $port.cash -= amount
        puts "  You bought #{(amount/price).round(4)}#{curr} for $#{amount}."
    else 
        puts "  You have $#{$port.cash}, so no deal"
    end
    menuChoice()
end

def sellCurr(currAmount, curr)
    price = getPrice(curr, "ask").round(2)
    currAmount = currAmount.to_i

    if currAmount <= $port.holdings[curr] 
        $port.cash += (currAmount*price).round(2)
        ($port.holdings[curr] -= currAmount).round(4)
        puts "  You sold #{currAmount}#{curr} for $#{(currAmount*price).round(2)}."
    else 
        puts "  You have #{$port.holdings[curr]}#{curr}, so no deal"
    end
    menuChoice()
end
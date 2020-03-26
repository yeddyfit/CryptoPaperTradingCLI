#### Paper trading CLI that uses BC exchange API price data
#### utilises btcmarkets data api, fetching and parsing SJON data
#### https://github.com/BTCMarkets/API/wiki/Market-data-API
# NOTE: remove APIs if made public

require 'httparty'
require 'terminal-table'
require 'tty-prompt'
$prompt = TTY::Prompt.new("")

require_relative('./users.rb')
require_relative('./portfolioClass.rb')


# create new portfolio array; else load existing.
if File.file?('user.dump')
    $ports = Marshal.load(File.read('user.dump'))
    puts `clear`
    userMenu()
else 
    $ports = []
    puts `clear`
    newUser()
end




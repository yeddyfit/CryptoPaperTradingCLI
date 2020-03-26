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
    self.send(putsTable($urls[curr]))
end
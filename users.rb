### code for creating/choosing new or existing user
require_relative './paperTrading.rb'


# $ports.push(Portfolio.new("King", "Jacob"))
# $port = $ports[0]

#Start out with no holdings and a balance of 5000
class Portfolio
    attr_accessor :user, :pass, :cash, :holdings
    def initialize(user, pass = "")
        @user = user
        @pass = pass
        @cash = 5000
        @holdings = {
            "ETH"=> 0,
            "BTC" => 0,
            "LTC" => 0
            }
    end
end


def chooseUser()
    names = []
    for i in 0..$ports.length-1 do
        names.push($ports[i].user)
    end

    choice = $prompt.select(" Choose Profile", names)

    for i in 0..$ports.length-1 do 
        if $ports[i].user = choice
            pass = $prompt.mask(" What's the password? ")
            if pass == $ports[i].pass
                $port = $ports[i]
            else
                puts " THER'S A RABBT IN THE SYSTM"
                userMenu()
            end
        end
    menuChoice()
end

def newUser()
    username = $prompt.ask(" New Username: ")
    password = $prompt.mask(" New Password: ")
    $ports.push(Portfolio.new(username, password))
    userMenu()
end

def saveUser()
    File.open('user.dump', 'w') { |f| f.write(Marshal.dump($ports)) }
    userMenu()
end

def userMenu()
    options = ["Choose User", "New User", "Save User", "Exit"]
    prompt = TTY::Prompt.new
    choice = prompt.select(" Choose menu \n", options)
    
    case choice
    when options[0]
        chooseUser()
    when options[1]
        newUser()
    when options[2]
        saveUser()
    when options[3]
        puts
        exit()
    end
end

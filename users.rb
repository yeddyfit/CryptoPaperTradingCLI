require_relative './paperTrading.rb'

def chooseUser()
    names = []
    $ports.each { |port| names.push(port.user) }

    choice = $prompt.select(" Choose Profile", names)
    $ports.each do |port|
        if port.user == choice
            pass = $prompt.mask(" What's the password? ")
            if pass == port.pass
                $port = port
            else
                puts " THER'S A RABBT IN THE SYSTM"
                userMenu()
            end
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
    options = {"Choose User" => "chooseUser", "New User" => "newUser", "Save User" => "saveUser", "Exit" => "exit"}
    command = $prompt.select(" Choose menu \n", options)
    self.send(command)
end

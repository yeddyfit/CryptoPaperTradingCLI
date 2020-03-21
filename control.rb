require_relative('./users.rb')


$prompt = TTY::Prompt.new("")



#create new portfolio array; or load existing.

if File.file?('user.dump')
    # NOTE: create entries as hash to make them name accesible?
    #       alternatively access port.names
    $ports = Marshal.load(File.read('user.dump'))
    puts `clear`
    userMenu()
else 
    $ports = []
    puts `clear`
    newUser()
end




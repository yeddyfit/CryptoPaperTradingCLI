
require 'httparty'
require 'tty-prompt'
require 'terminal-table'

require_relative('./users.rb')


$prompt = TTY::Prompt.new("")


#create new portfolio array; or load existing.
if File.file?('user.dump')
    $ports = Marshal.load(File.read('user.dump'))
    puts `clear`
    userMenu()
else 
    $ports = []
    puts `clear`
    newUser()
end




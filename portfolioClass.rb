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

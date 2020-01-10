class Crypto < ApplicationRecord
    validates :symbol, :name, presence: true, uniqueness: true

    has_many :portfolios
    has_many :transactions

    def self.fetch_current_value(symbols)
        url = 'https://min-api.cryptocompare.com/data/pricemulti?fsyms='
        syms = symbols.join(',').concat('&tsyms=USD&api_key=')
        api_key = Rails.application.credentials.cryptocompare[:api_key]
        response = Faraday.get url+syms+api_key
        values = JSON.parse(response.body)
        # debugger
        # https://min-api.cryptocompare.com/data/pricemulti?fsyms=ETH,DASH&tsyms=BTC,USD,EUR&api_key=INSERT-YOUR-API-KEY-HERE
    end

end
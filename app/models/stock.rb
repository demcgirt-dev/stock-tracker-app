class Stock < ActiveRecord::Base
  
  #-----------------------------------------------------------------------------------------------
  # Find method that returns the first record in our stocks table matching the given ticker symbol.
  #-----------------------------------------------------------------------------------------------
  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
  
  #-----------------------------------------------------------------------------------------------
  # Look up method that returns a variable set equal to a StockQuote object if it is found. 
  # A new model object is then created & assigned a ticker & name value taken from the StockQuote object.
  # The new Stock model object is then returned.
  #-----------------------------------------------------------------------------------------------
  def self.new_from_lookup(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return nil unless looked_up_stock.name
    
    new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
    new_stock.last_price = new_stock.price
    new_stock
  end
  
  #-----------------------------------------------------------------------------------------------
  # Price method that returns the closing price if it exists, otherwise returns the opening price.
  # If neither prices are available, the string 'Unavailable' is returned.
  #-----------------------------------------------------------------------------------------------
  def price
    closing_price = StockQuote::Stock.quote(ticker).close
    return "#{closing_price} (closing)" if closing_price
    
    opening_price = StockQuote::Stock.quote(ticker).open
    return "#{opening_price} (Opening)" if opening_price
    'Unavailable'
  end
  
end

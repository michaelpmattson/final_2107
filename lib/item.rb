class Item
  attr_reader :name,
              :bids

  def initialize(name)
    @name = name
    @bids = {}
  end

  def add_bid(bidder, amount)
    @bids[bidder] = amount
  end

  def current_high_bid
    high = 0
    @bids.each do |bidder, amount|
      high = @bids[bidder] if @bids[bidder] > high
    end
    high
  end
end

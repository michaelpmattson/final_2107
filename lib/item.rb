class Item
  attr_reader :name,
              :bids

  def initialize(name)
    @name           = name
    @bids           = {}
    @bidding_closed = false
  end

  def add_bid(bidder, amount)
    @bids[bidder] = amount unless bidding_closed?
  end

  def current_high_bid
    high = 0
    @bids.each do |bidder, amount|
      high = @bids[bidder] if @bids[bidder] > high
    end
    high
  end

  def close_bidding
    @bidding_closed = true
  end

  def bidding_closed?
    @bidding_closed
  end

  def current_high_bidder
    high_bidder = nil
    high_bid = 0
    @bids.each do |bidder, amount|
      high_bidder = bidder if amount > high_bid
    end
    high_bidder
  end
end

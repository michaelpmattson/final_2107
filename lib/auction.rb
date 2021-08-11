require 'date'

class Auction
  attr_reader :items,
              :date

  def initialize
    @items = []
    @date  = Date.today.strftime("%d/%m/%Y")
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map do |item|
      item.name
    end
  end

  def unpopular_items
    @items.find_all do |item|
      item.bids.count == 0
    end
  end

  def potential_revenue
    @items.sum do |item|
      item.current_high_bid
    end
  end

  def bidders
    bidders = []
    @items.each do |item|
      item.bids.each do |bidder, amount|
        bidders << bidder.name
      end
    end
    bidders.uniq
  end

  def bidder_info
    bidder_info = Hash.new { |h, k| h[k] = { budget: nil, items: [] } }
    @items.each do |item|
      item.bids.each do |bidder, amount|
        bidder_info[bidder][:budget] = bidder.budget
        bidder_info[bidder][:items] << item
      end
    end
    bidder_info
  end

  def close_auction
    close_bidding

    close_auction = {}
    bidder_info.each do |bidder, info|
      # require "pry"; binding.pry
    end
    close_auction
  end

  def close_bidding
    @items.each do |item|
      item.close_bidding
    end
  end
end

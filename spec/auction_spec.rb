require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Auction do
  describe '#initialize' do
    it 'exists and has attributes' do
      allow(Date).to receive(:today).and_return(Date.new(2020, 2, 24))
      auction = Auction.new

      expect(auction).to be_an_instance_of(Auction)
      expect(auction.items).to eq([])
      expect(auction.date).to eq("24/02/2020")
    end
  end

  describe '#add_item(item)' do
    it 'adds an item to list' do
      auction = Auction.new
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')

      auction.add_item(item1)
      auction.add_item(item2)

      expect(auction.items).to eq([item1, item2])
    end
  end

  describe '#item_names' do
    it 'lists item names' do
      auction = Auction.new
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')

      auction.add_item(item1)
      auction.add_item(item2)

      expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end

  describe '#unpopular_items' do
    it 'lists items with no bid' do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')

      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')
      attendee3 = Attendee.new(name: 'Mike', budget: '$100')

      auction = Auction.new

      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)

      expect(auction.unpopular_items).to eq([item2, item3, item5])

      item3.add_bid(attendee2, 15)

      expect(auction.unpopular_items).to eq([item2, item5])
    end
  end

  describe '#potential_revenue' do
    it 'returns total possible sale price of the items (highest bid)' do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')

      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')
      attendee3 = Attendee.new(name: 'Mike', budget: '$100')

      auction = Auction.new

      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)

      expect(auction.potential_revenue).to eq(87)
    end
  end

  describe '#bidders' do
    it 'lists bidder names' do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')

      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')
      attendee3 = Attendee.new(name: 'Mike', budget: '$100')

      auction = Auction.new

      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee1, 22)
      item1.add_bid(attendee2, 20)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)

      expect(auction.bidders).to eq(["Megan", "Bob", "Mike"])
    end
  end

  describe '#bidder_info' do
    it 'lists bidder budgets and items' do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')

      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')
      attendee3 = Attendee.new(name: 'Mike', budget: '$100')

      auction = Auction.new

      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee1, 22)
      item1.add_bid(attendee2, 20)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)

      expectation = {
        attendee1 => { :budget => 50,  :items => [item1] },
        attendee2 => { :budget => 75,  :items => [item1, item3] },
        attendee3 => { :budget => 100, :items => [item4] }
      }

      expect(auction.bidder_info).to eq(expectation)
    end
  end

  describe '#close_auction' do
    it 'turns off all bidding' do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')

      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')
      attendee3 = Attendee.new(name: 'Mike', budget: '$100')

      auction = Auction.new

      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee1, 22)
      item1.add_bid(attendee2, 20)
      item4.add_bid(attendee2, 30)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)
      item5.add_bid(attendee1, 35)

      auction.close_auction

      expect(item1.bidding_closed?).to be(true)
      expect(item5.bidding_closed?).to be(true)
    end

    xit 'sells all items' do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')

      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')
      attendee3 = Attendee.new(name: 'Mike', budget: '$100')

      auction = Auction.new

      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee1, 22)
      item1.add_bid(attendee2, 20)
      item4.add_bid(attendee2, 30)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)
      item5.add_bid(attendee1, 35)

      close = auction.close_auction

      expectation = {
        item1 => attendee2,
        item2 => 'Not Sold',
        item3 => attendee2,
        item4 => attendee3,
        item5 => attendee1
      }

      expect(close).to eq(expectation)
    end
  end
end

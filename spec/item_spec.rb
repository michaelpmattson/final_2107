require './lib/item'
require './lib/attendee'

RSpec.describe Item do
  describe '#initialize' do
    it 'exists and has attributes' do
      item1 = Item.new('Chalkware Piggy Bank')

      expect(item1).to be_an_instance_of(Item)
      expect(item1.name).to eq("Chalkware Piggy Bank")
    end
  end

  describe '#add_bid(bidder, amount)' do
    it 'lists bids by bidder' do
      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')

      item1 = Item.new('Chalkware Piggy Bank')

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)

      expectation = {attendee2 => 20, attendee1 => 22}

      expect(item1.bids).to eq(expectation)
    end
  end

  describe '#current_high_bid' do
    it 'returns the current highest bid' do
      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')

      item1 = Item.new('Chalkware Piggy Bank')

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)

      expect(item1.current_high_bid).to eq(22)
    end
  end

  describe '#close_bidding' do
    it 'stops new bids from being added' do
      item1 = Item.new('Chalkware Piggy Bank')
      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')
      attendee3 = Attendee.new(name: 'Mike', budget: '$100')

      item1.add_bid(attendee1, 22)
      item1.add_bid(attendee2, 20)

      expectation = {attendee1 => 22, attendee2 => 20}

      expect(item1.bids).to eq(expectation)

      item1.close_bidding

      item1.add_bid(attendee3, 70)

      expect(item1.bids).to eq(expectation)
    end
  end

  describe '#current_high_bidder' do
    it 'returns the current highest bid' do
      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')

      item1 = Item.new('Chalkware Piggy Bank')

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)

      expect(item1.current_high_bidder).to eq(attendee1)
    end
  end
end

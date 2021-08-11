require './lib/auction'

RSpec.describe Auction do
  describe '#initialize' do
    it 'exists and has attributes' do
      auction = Auction.new

      expect(auction).to be_an_instance_of(Auction)
      expect(auction.items).to eq([])
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
end

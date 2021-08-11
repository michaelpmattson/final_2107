require './lib/item'

RSpec.describe Item do
  describe '#initialize' do
    it 'exists and has attributes' do
      item1 = Item.new('Chalkware Piggy Bank')

      expect(item1).to be_an_instance_of(Item)
      expect(item1.name).to eq("Chalkware Piggy Bank")
    end
  end
end

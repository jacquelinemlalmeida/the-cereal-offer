require 'rails_helper'

RSpec.describe OrderHelper, type: :helper do

  describe '#calculate_discount' do
    it "should return a 25% of discount for a cart with 5 or more cereal boxes diff from brand KETO" do
      line_items = [
        { "name": "Peanut Butter", "price": "10.0", "collection": "BEST-SELLERS" },
        { "name": "Banana Cake", "price": "10.00", "collection": "DEFAULT" },
        { "name": "Banana Cake2", "price": "10.00", "collection": "DEFAULT" },
        { "name": "Banana Cake3", "price": "10.00", "collection": "DEFAULT" },
        { "name": "Cocoa", "price": "20.00", "collection": "KETO" },
        { "name": "Fruity", "price": "10.00", "collection": "DEFAULT" }
      ]

      expect(helper.calculate_discount(line_items)[:total_discount]).to be == 57.5 
    end

    it "should return a 20% of discount for a cart with 4 cereal boxes diff from brand KETO" do
      line_items = [
        { "name": "Peanut Butter", "price": "10.0", "collection": "BEST-SELLERS" },
        { "name": "Banana Cake", "price": "10.00", "collection": "DEFAULT" },
        { "name": "Banana Cake2", "price": "10.00", "collection": "DEFAULT" },
        { "name": "Cocoa", "price": "20.00", "collection": "KETO" },
        { "name": "Fruity", "price": "10.00", "collection": "DEFAULT" }
      ]

      expect(helper.calculate_discount(line_items)[:total_discount]).to be == 52.0
    end

    it "should return a 10% of discount for a cart with 3 cereal boxes diff from brand KETO" do
      line_items = [
        { "name": "Peanut Butter", "price": "10.0", "collection": "BEST-SELLERS" },
        { "name": "Banana Cake2", "price": "10.00", "collection": "DEFAULT" },
        { "name": "Cocoa", "price": "20.00", "collection": "KETO" },
        { "name": "Fruity", "price": "10.00", "collection": "DEFAULT" }
      ]

      expect(helper.calculate_discount(line_items)[:total_discount]).to be == 47.0
    end

    it "should return a 5% of discount for a cart with 3 cereal boxes diff from brand KETO" do
      line_items = [
        { "name": "Peanut Butter", "price": "10.0", "collection": "BEST-SELLERS" },
        { "name": "Cocoa", "price": "20.00", "collection": "KETO" },
        { "name": "Fruity", "price": "10.00", "collection": "DEFAULT" }
      ]

      expect(helper.calculate_discount(line_items)[:total_discount]).to be == 39.0
    end
  end
end

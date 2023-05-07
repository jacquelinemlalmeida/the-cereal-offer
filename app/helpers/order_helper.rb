module OrderHelper
  EXCLUDED_BRANDS = ["KETO"]
  TWO_CEREAL_DISCOUNT = 0.05
  THREE_CEREAL_DISCOUNT = 0.1
  FOUR_CEREAL_DISCOUNT = 0.2
  FIVE_OR_MORE_CEREAL_DISCOUNT = 0.25
  PROMO_1 = 2
  PROMO_2 = 3
  PROMO_3 = 4
  PROMO_4 = 5
  

  
  def calculate_discount(line_items) 
    items = {}
    @line_items = line_items.reject {|i| i.blank?}

    items[:line_items] = line_items.map do |item|
      @item = item
      next if item.blank?
      
      if excluded_brand?
        { name: @item[:name], discounted_price: @item[:price].to_f } 
      else
        promotion
      end
    end.compact

    total_discount = items[:line_items].pluck(:discounted_price).sum()
    
    items.merge({total_discount: total_discount})
  end

  private 
  
  def total_of_discounted_items
    @line_items.reject {|i| EXCLUDED_BRANDS.include? i[:collection]}.size
  end

  def discounted_price(discounted_level)
    discount_rate = 1-discounted_level
    (@item[:price].to_f*discount_rate).round(2)
  end

  def excluded_brand?
    EXCLUDED_BRANDS.include? @item[:collection]
  end

  def promotion
    case total_of_discounted_items
      
    when PROMO_1
      {
        name: @item[:name], 
        discounted_price: discounted_price(TWO_CEREAL_DISCOUNT)
      }
    when PROMO_2
      {
        name: @item[:name], 
        discounted_price: discounted_price(THREE_CEREAL_DISCOUNT)
      }
    when PROMO_3
      {
        name: @item[:name], 
        discounted_price: discounted_price(FOUR_CEREAL_DISCOUNT)
      }
    else 
      if total_of_discounted_items >= PROMO_4
        {
          name: @item[:name], 
          discounted_price: discounted_price(FIVE_OR_MORE_CEREAL_DISCOUNT)
        }
      else  
        {
          name: @item[:name], 
          discounted_price: @item[:price].to_f
        }
      end
    end
  end
end
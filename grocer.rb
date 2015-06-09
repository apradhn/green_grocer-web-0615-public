def consolidate_cart(cart:[])
  item_names = cart.collect{|item| item.keys.first}

  cart.uniq.each.with_object({}) do |item, cart_count|
    item_name = item.keys.first
    cart_count[item_name] = {
      price: item[item_name][:price],
      clearance: item[item_name][:clearance],
      count: item_names.count{|name| item_name == name}
    }
  end
end

def apply_coupons(cart:[], coupons:[])
  cart.each.with_object({}) do |(item, properties), cart_with_coupons|
    if coupons.any?{|coupon| coupon[:item] == item}
      coupon_data = coupons.find{|coupon| coupon[:item] == item}
      cart_with_coupons[item] = {
        price: properties[:price],
        clearance: properties[:clearance],
        count: properties[:count]
      }
      cart_with_coupons["#{item} W/COUPON"] = {
        price: coupon_data[:cost],
        clearance: properties[:clearance],
        count: 0
      }
      while cart_with_coupons[item][:count] >= coupon_data[:num]
        cart_with_coupons[item][:count] -= coupon_data[:num] 
        cart_with_coupons["#{item} W/COUPON"][:count] += 1
      end
    else
      cart_with_coupons[item] = {
        price: properties[:price],
        clearance: properties[:clearance],
        count: properties[:count]
      }      
    end
  end
end

def apply_clearance(cart:[])
  cart.each do |item, properties|
    if properties[:clearance] == true
      properties[:price] = properties[:price] - (properties[:price] * 0.2)
    end
  end
  cart
end

def checkout(cart: [], coupons: [])
  consol_cart = consolidate_cart(cart: cart)
  cart_after_coupons = apply_coupons(cart: consol_cart, coupons: coupons)
  cart_after_clearance = apply_clearance(cart: cart_after_coupons)
  total = cart_after_clearance.collect{|item, properties| properties[:price] * properties[:count]}.inject{|sum, price| sum + price}
  if total > 100
    total -= total * 0.1
  end
  total
end
require_relative "../grocer.rb"

avocado = {"AVOCADO" => {:price => 3.00, :clearance => true}},
kale = {"KALE" => {:price => 3.00, :clearance => false}},
black_beans = {"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
almonds = {"ALMONDS" => {:price => 9.00, :clearance => false}},
tempeh = {"TEMPEH" => {:price => 3.00, :clearance => true}},
cheese = {"CHEESE" => {:price => 6.50, :clearance => false}},
beer = {"BEER" => {:price => 13.00, :clearance => false}},
peanut_butter = {"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
beets = {"BEETS" => {:price => 2.50, :clearance => false}},
milk = {"SOY MILK" => {:price => 4.50, :clearance => true}}

avocado_coupon = {:item => "AVOCADO", :num => 2, :cost => 5.00},
beer_coupon = {:item => "BEER", :num => 2, :cost => 20.00},
cheese_coupon = {:item => "CHEESE", :num => 3, :cost => 15.00}

puts  "#apply_clearance after calling on #apply_coupons with multiple items, coupons, and items are on clearance" 
cart = [milk, avocado, avocado, cheese, cheese, cheese]
coupons = [avocado_coupon, cheese_coupon]

puts consolidate_cart(cart: cart)
# README
Hi, I'm Bill, this is one of projects for my exercise, A Shopping Store!
Most of rails courses would take EC to be a example to teaching.
So I just make it a little change and add a easy rspec to test.

http://luxury-shop-store.herokuapp.com/
admin: admin@test.com
password: 1234567

## Gem
- [friendly_id](https://github.com/norman/friendly_id), Create pretty URLs

- [seo_helper](https://github.com/techbang/seo_helper)

- [fog](https://github.com/fog/fog), The Ruby cloud services library, 連結S3

- [figaro](https://github.com/laserlemon/figaro), 管理機密資訊、密碼的gem

- [roadie](https://github.com/Mange/roadie), send HTML email

- [aasm](https://github.com/aasm/aasm), state machine(狀態機)

- [carrierwave](https://github.com/carrierwaveuploader/carrierwave), 上傳檔案

- [mini_magick](https://github.com/minimagick/minimagick), 縮圖工具 需要先安裝圖像處理工具-ImageMagick

- [simple_form](https://github.com/plataformatec/simple_form), 更簡單使用form的helper

- [faker](https://github.com/stympy/faker), A library for generating fake data

- [factory_girl_rails](https://github.com/thoughtbot/factory_girl_rails), 產生測試用的資料

- [devise](https://github.com/plataformatec/devise), 使用者認證套件

- [letter_opener](https://github.com/ryanb/letter_opener), Preview mail in the browser instead of sending.

- [rspec-rails](https://github.com/rspec/rspec-rails)

## User Story
- 身為管理者，可以在後台新增產品。
	- 身為管理者，新增的產品可以上架或下架。
		- 首頁只會出現已上架的產品。

- 身為管理者，可以在後台編輯和刪除自己新增的產品。(利用cart & cart_items的destroy)
- 身為管理者，可以在後台看到產品列表。
- 身為管理者，可以在後台看到使用者列表。

	- 身為管理者，可以在後台變更其他使用者的權限。
- 身為管理者，可以在後台看到訂單列表。
- 身為管理者，可以在後台看到訂單的狀態以及手動變更訂單狀態。

- 身為使用者，我可以購買產品。
	- 身為使用者，我可以將產品加入購物車裡。

- 身為使用者，我可以在購物車裡增加或減少數量。
- 身為使用者，我可以選擇結帳。
	- 身為使用者，我可以在結帳頁面輸入相關收件人及地址等資料。
	- 身為使用者，當我填寫完資料時並確認時，會收到一份訂單成立的email。

- 身為使用者，我可以選擇付款方式做付款的動作。
- 身為使用者，我可以看到自己的訂單列表。
- 身為使用者，我可以將商品分享到我的FB和Google Plus
- 身為使用者，我可以在商品頁面看到平均分數和評論。
- 身為使用者，我可以在商品的頁面發表評論。
	- 身為使用者，我可以替商品評分（0~5）。

- 身為使用者，我可以在首頁看到商品的平均分數和評論數。



## Notes
- 將購物車以及AASM的設定放在concern裡。
```ruby
# controllers/concern/current_cart.rb
module CurrentCart
  extend ActiveSupport::Concern
  private
  def set_cart
    @current_cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @current_cart = Cart.create
    session[:cart_id] = @current_cart.id
  end
end
```
```ruby
module AasmState
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm do
      state :order_placed, initial: true
      state :paid
      state :shipping
      state :arrived
      state :order_canceled
      state :good_returned

      event :make_payment, after_commit: :pay! do
        transitions from: :order_placed, to: :paid
      end
      .
      .(略)
end
```

- 加入購物車，如果商品已存在，數量就加1，不然就create一個。
```ruby
def add_product_to_cart(product)
  	current_item = cart_items.find_by(product_id: product.id)
  	if current_item
  		current_item.quantity +=1
  	else
	  	current_item = cart_items.build(product_id: product.id, price: product.price)
      cart_items << current_item
	  end
	  current_item
 end
```

- 加總
```ruby
def total_price
  cart_items.inject(0){|sum, item| sum + (item.price * item.quantity)}
 end
  # inject是ruby的語法，他會把陣列裡的元素拉出來做運算加總。
```
	
- 利用migration 將price帶進之後才新增的欄位
```ruby
class AddPriceToCartItems < ActiveRecord::Migration
  def up
    add_column :cart_items, :price, :integer
    CartItem.all.each do |item|
    	item.update(price: item.product.price)
    end
  end

  def down
  	remove_column :cart_items, :price
  end
end
```

- 無效商品網頁得轉址
```ruby
# products_controller.rb
rescue_from ActiveRecord::RecordNotFound, with: :invalid_product

private

def invalid_product
	logger.error "Attemt to access invalid product #{params[:id]}" # 添加錯誤訊息到log裡
	redirect_to root_url, notice: "The product isn't exist or on sale!"
end

```



- 在購物車裡利用ajax添加或減少數量
```ruby
def increse(cart_item_id)
    current_item = cart_items.find_by_id(cart_item_id)
    current_item.quantity +=1
    current_item
  end

  def decrese(cart_item_id)
    current_item = cart_items.find_by_id(cart_item_id)
    if current_item.quantity > 1
      current_item.quantity -= 1
    else
      current_item.destroy
    end
    current_item
  end
```

- 當購物車沒有任何商品時，應該要把table隱藏起來
```ruby 
# application_helper.rb
def hidden_div_if(condition, attributes= {}, &block)
    if condition
      attributes["style"] = 'display: none'
      content_tag("h2", "There aren't any products in your cart", id: 'no_item_message')
    else
      content_tag("div", attributes, &block)
    end
end
```

- 在product裡新增一個欄位on_sale:boolean，來做上架或下架的功能。index 可以改成`@products = Product.where(on_sale: true)` 來更改搜尋條件

- 利用content_for 在頁面挖一個洞
```html
	# common/_side.html.erb
  <div class="col-md-3">
    <p class="lead">User Function</p>
    <div class="list-group">
      <%= link_to "My Orders", orders_path, class: "list-group-item"  %>
      <%= link_to carts_path, class: "list-group-item" do  %>
        My Cart <i class="fa fa-shopping-cart fa-lg">( <%= render_cart_items_count(@current_cart) %> )</i>
      <% end %>
    </div>
    <%= yield :comment %>
  </div>
```

```html
# views/product/show.html.erb
<%= content_for :comment do %>
  <%= render 'comments/comment', comments:@comments %>
<% end %>
.
.(略)
```

- 利用letter_opener可以預覽信件, 利用mailgun服務來完成寄信。

- 利用AWS的S3儲存圖片

- 利用繼承來整理重複的controller
```ruby
# 新增admin_controller.rb
class AdminController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required
end
# 之後在admin裡的controller都改為繼承AdminController
```
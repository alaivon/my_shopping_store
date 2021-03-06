class Product < ActiveRecord::Base
  has_many :cart_items
  validates :title, :description, :price, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 1}, allow_blank: true
  validates :title, uniqueness: true
  before_destroy :ensure_not_add_in_cart
  has_one :photo
  has_many :comments
  accepts_nested_attributes_for :photo
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]


  def turn_on_sale
    self.update(on_sale: true)
  end

  def turn_off_sale
    self.update(on_sale: false)
  end

  def should_generate_new_friendly_id?
    title_changed?
  end


  private

  def ensure_not_add_in_cart
    unless cart_items.empty?
      errors.add(:base, 'Cart Items present')
      throw :abort
    end
  end





end

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

      event :ship do
        transitions from: :paid, to: :shipping
      end

      event :deliver do
        transitions from: :shipping, to: :arrived
      end

      event :cancel do
        transitions from: [:order_placed, :paid], to: :order_canceled
      end

      event :return do
        transitions from: :arrived, to: :good_returned
      end
    end
  end
end
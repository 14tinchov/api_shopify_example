module StripeService
  class Base
    def initialize
    end

    def get_customer(stripe_customer_id)
      Stripe::Customer.retrieve(stripe_customer_id)
    end

    def usd_to_cents(usd)
      (usd * 100).to_i
    end
  end
end
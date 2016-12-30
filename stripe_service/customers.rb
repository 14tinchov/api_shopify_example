module StripeService
  class Customers < Base
    attr_accessor :user

    def initialize(user = nil)
      @user = user
    end

    def create_customer_id
      customer = Stripe::Customer.create(
        email: user.email
      )
      user.update_attributes(stripe_customer_id: customer.id)
    end

    def self.get_customers(stripe_access_code, limit=20)
      Stripe.api_key = stripe_access_code
      data = Stripe::Customer.list(limit: limit)[:data]
      Stripe.api_key = ENV['STRIPE_API_KEY']
      return data
    end
  end
end

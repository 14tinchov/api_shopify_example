module StripeService
  class Balance < Base
    
    def initialize;end

    def self.get_balance(stripe_access_code)
      if stripe_access_code
        Stripe.api_key = stripe_access_code
        balance = Stripe::Balance.retrieve
        Stripe.api_key = ENV['STRIPE_API_KEY']
        return balance
      else
        return "0"
      end
    end

  end
end

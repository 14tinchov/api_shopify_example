module StripeService
  class Charges < Base
    attr_accessor :charge
    
    def initialize(charge = nil)
      @charge = charge
    end

    def create_charge_id(total_amount, customer_id, company_id, fee)
      stripe_charge = Stripe::Charge.create(
        customer: customer_id,
        amount: usd_to_cents(total_amount),
        application_fee: usd_to_cents(fee),
        currency: "usd",
        description: "description",
        destination: company_id
      )

      charge.update_attributes(stripe_charge_id: stripe_charge.id)
    end

    def self.get_charges(stripe_access_code, limit=20)
      Stripe.api_key = stripe_access_code
      data = Stripe::Charge.list(limit: limit)[:data]
      Stripe.api_key = ENV['STRIPE_API_KEY']
      return data
    end

    def get_charge(stripe_charge_id)
      Stripe::Charge.retrieve(stripe_charge_id)
    end

  end
end

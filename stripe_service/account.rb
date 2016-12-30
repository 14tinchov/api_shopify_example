module StripeService
  class Account < Base
    def self.get_info(stripe_id_account)
      Stripe::Account.retrieve(stripe_id_account)
    end
  end
end
module StripeService
  class Cards < Base

    def associate_user_with_credit_card(user, credit_card_token)
      customer_id = user.stripe_customer_id
      customer = get_customer(customer_id)
      default_card = false
      default_card = true unless user.credit_cards.any?
      card = customer.sources.create(source: credit_card_token)
      return {
        stripe_card_id: card.id ,
        is_default: default_card,
        brand: card.brand,
        country: card.country,
        cvc_check: card.cvc_check,
        last4: card.last4,
        exp_month: card.exp_month,
        exp_year: card.exp_year,
        funding: card.funding,
        name: card.name
      }
    end

    def self.setting_default_card(user, credit_card_id)
      customer_id = user.stripe_customer_id
      cu = Stripe::Customer.retrieve(customer_id)
      cu.default_source = credit_card_id
      cu.save
    end

    def get_all_cards(stripe_customer_id)
      Stripe::Customer.retrieve(stripe_customer_id).sources.all(:object => "card")
    end
  end
end
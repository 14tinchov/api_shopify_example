include ActionView::Helpers::TextHelper

module StripeService
  class Plans < Base
    def create_plan_id(package)
      plan = Stripe::Plan.create(
        id: package.stripe_plan_name,
        amount: usd_to_cents(package.bundle_price),
        interval: package.interval,
        name: package.try(:name) || package.stripe_plan_name,
        statement_descriptor: package.stripe_description,
        currency: "usd"
      )

      package.update_attributes(stripe_plan_id: plan.id)
    end
  end
end

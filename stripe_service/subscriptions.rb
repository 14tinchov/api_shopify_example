module StripeService
  class Subscriptions < Base

    def create_subscription_id(user, package, subscription)
      customer = get_customer(user.stripe_customer_id)
      stripe_subscription = customer.subscriptions.create(plan: package.stripe_plan_id)

      subscription.update_attributes(
        stripe_subscription_id: stripe_subscription.id,
        stripe_status:          stripe_subscription.status,
        stripe_period_start:    stripe_subscription.current_period_start,
        stripe_period_ends:     stripe_subscription.current_period_end,
        stripe_started_at:      stripe_subscription.start,
        stripe_sub_quantity:    stripe_subscription.quantity, 
        stripe_interval:        stripe_subscription.plan.interval,
        stripe_interval_count:  stripe_subscription.plan.interval_count,
        stripe_plan_amount:     stripe_subscription.plan.amount)
    end

    def unsubscribe_subscription(user, subscription)
      customer = get_customer(user.stripe_customer_id)
      sub = customer.subscriptions.retrieve(subscription.stripe_subscription_id)
      sub.delete
    end

    def self.get_subscriptions(stripe_access_code, limit = 20)
      Stripe.api_key = stripe_access_code
      data = Stripe::Subscription.all(limit: limit)[:data]
      Stripe.api_key = ENV['STRIPE_API_KEY']
      return data
    end
  end
end

module ShopifyService
  class Orders < Base
    attr_accessor :shop, :charge

    def initialize(company, charge)
      @charge = charge
      @shop = open_session(company.shopify_name, company.shopify_token)
    end

    def create
      order = ShopifyAPI::Order.create(
        email: charge.user.email,
        financial_status:"authorized",
        line_items: build_line_items
      )
      puts "=================== ShopifyAPI RESPONSE ==================="
      puts order.inspect
    end

  private
    def build_line_items
      line_items = charge.product_line_items
      line_items.each.inject([]) do |rtn, line_item|
        rtn << {quantity: line_item.quantity, variant_id: line_item.product_variant.product.shopify_id}
      end
    end
  end
end

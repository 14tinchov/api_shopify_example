module ShopifyService
  class Base
    def initialize()
    end

    def close_session
      ShopifyAPI::Base.clear_session
    end 

  protected
    def open_session(shopify_name, shopify_token)
      session = ShopifyAPI::Session.new(shopify_name, shopify_token)
      ShopifyAPI::Base.activate_session(session)
      shop = ShopifyAPI::Shop.current
    end
  end
end
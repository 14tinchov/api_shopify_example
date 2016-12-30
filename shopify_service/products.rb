module ShopifyService
  class Products < Base
    attr_accessor :shop

    def initialize(company)
      @shop = open_session(company.shopify_name, company.shopify_token)
    end

    def get_all()
      ShopifyAPI::Product.all
    end

    def select_options()
      ShopifyAPI::Product.all.collect(){|e| [e.title, e.variants.first.id]}
    end    
  end
end

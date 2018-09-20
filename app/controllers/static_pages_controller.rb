class StaticPagesController < ApplicationController

  def home
  end

  def privacy
  end

  def terms
  end

  def become_member
    if user_signed_in?
      Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"
      @customer = Stripe::Customer.retrieve(current_user.customer_id)
      if current_user.merchant.present?
        @merchant = Stripe::Account.retrieve(current_user.merchant.stripe_id)
      end
    end
  end
  
end
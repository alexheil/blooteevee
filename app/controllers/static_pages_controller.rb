class StaticPagesController < ApplicationController

  def home
  end

  def become_member
    if user_signed_in?
      Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"
      @customer = Stripe::Customer.retrieve(current_user.customer_id)
    end
  end
  
end
class Users::SubscriptionsController < ApplicationController

  def create

    @subscriber = current_user
    @subscribed = User.friendly.find(params[:subscribed_id])

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"
    customer = Stripe::Customer.retrieve(@subscriber.customer_id)

    token = Stripe::Token.create({
      customer: customer.id,
      card: customer.default_source,
    }, stripe_account: @subscribed.merchant.stripe_id)

    subscription_customer = Stripe::Customer.create({
      email: @subscriber.email
    }, stripe_account: @subscribed.merchant.stripe_id)

    plan = Stripe::Plan.retrieve(@subscribed.plan.plan_id, stripe_account: @subscribed.merchant.stripe_id)

    subscription = Stripe::Subscription.create({
      customer: subscription_customer.id,
      source: token,
      application_fee_percent: 10,
      items: [
        {plan: plan.id}
      ],
    }, stripe_account: @subscribed.merchant.stripe_id)

    subscription.save

    if subscription.save
      user = User.find(params[:subscribed_id])
      @subscriber.active_subscriptions.create(
        stripe_subscription_id: subscription.id,
        subscriber_id: @subscriber.id,
        subscribed_id: @subscribed.id
      )
      redirect_to user_path(user)
      flash[:notice] = "You subscribed to #{user.profile.first_name.presence || user.username}!"
    else 
      redirect_to root_url
    end
  end

  def destroy





    user = Subscription.find(params[:id]).subscribed
    current_user.unsubscribe(user)
    redirect_to user
  end

end
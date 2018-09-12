class Users::MembershipsController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user
  before_action :set_user

  def new
    @membership = Membership.new
  end

  def create

    @membership.update_attributes(
      current_id: params[:membership][:membership_type] + "_id"
    )
   
    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    # find customer
    customer = Stripe::Customer.retrieve(@user.customer_id)
    
    # check if customer has a source on file
    if customer.default_source.blank?
      url = "#{request.protocol}#{request.host_with_port}#{request.fullpath}/edit"
      redirect_to edit_source_path(@user, :url => Base64.encode64(url))
    else
      # if user has subscription find it if not create it
      if @membership.membership_id.blank?
        # create a Stripe membership
        subscription = Stripe::Subscription.create({
        customer: customer.id,
          items: [{plan: @membership.current_id}],
        })
      else
        # grab Stripe membership and update it
        subscription = Stripe::Subscription.retrieve(@membership.membership_id)
        subscription.items = [{
          id: subscription.items.data[0].id,
          plan: @membership.current_id
        }]
      end

      subscription.save

      if subscription.save
        @user.create_membership(
          membership_id: subscription.id,
          membership_type: params[:membership][:membership_type]
        )
        redirect_to user_path(@user)
      end
    end

  end

  def edit
    @membership = @user.membership
  end

  def update
    @membership = @user.membership

    # update current_id to match plan id
    @membership.update_attributes(
      current_id: params[:membership][:membership_type] + "_id"
    )
   
    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    # find customer
    customer = Stripe::Customer.retrieve(@user.customer_id)
    
    # check if customer has a source on file
    if customer.default_source.blank?
      url = "#{request.protocol}#{request.host_with_port}#{request.fullpath}/edit"
      redirect_to edit_source_path(@user, :url => Base64.encode64(url))
    else
      # if user has subscription find it if not create it
      if @membership.membership_id.blank?
        # create a Stripe membership
        subscription = Stripe::Subscription.create({
        customer: customer.id,
          items: [{plan: @membership.current_id}],
        })
      else
        # grab Stripe membership and update it
        subscription = Stripe::Subscription.retrieve(@membership.membership_id)
        subscription.items = [{
          id: subscription.items.data[0].id,
          plan: @membership.current_id
        }]
      end

      subscription.save

      if subscription.save
        @membership.update_attributes(
          membership_id: subscription.id,
          membership_type: params[:membership][:membership_type]
        )
        redirect_to user_path(@user)
      end
    end

  end

  private

    def set_user
      @user = current_user
    end

    def correct_user
      @user = User.friendly.find(params[:user_id])
      if current_user != @user
        redirect_to user_path(@user)
        flash[:alert] = "This is not your profile."
      end
    end

    def membership_params
      params.require(:membership).permit(:stripe_subscription_id, :current_id, :membership_type)
    end

end

class ChargesController < ApplicationController
  def new
    if !current_user
      flash[:error] = "You must register first before you can upgrade to a premium account."
      redirect_to new_user_registration_path
    else
      @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "Premium Membership - #{current_user.name}",
        amount: @amount
      }
    end
  end

  def create
    # Amount in cents
    @amount = 1500

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    if current_user.update_attributes!(role: 'premium')
      flash[:notice] = "Thanks for your payment, #{current_user.name}!  You are now a Premium Member!"
      redirect_to user_path(current_user)
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end

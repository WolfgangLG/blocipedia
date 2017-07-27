class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "BlocipediaMembership - #{current_user.username}",
        amount: 19_99
    }
  end

  def create
    @amount = 19_99

    customer = Stripe::Customer.create(
      email: current_user.email,
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "BlocipediaMembership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thank you for you payment, #{current_user.username}! You can downgrade your account at any time."
    redirect_to user_path(current_user)

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end
end

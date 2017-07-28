class ChargesController < ApplicationController
  before_action :amount_to_be_charged

  def new
    @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "BlocipediaMembership - #{current_user.username}",
        amount: @amount
    }
  end

  def create

    customer = StripeService.new(
      email: current_user.email,
      source: params[:stripeToken]
    ).create_customer

    charge = StripeService.new(
      customer: customer.id,
      amount: @amount,
      description: "BlocipediaMembership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thank you for you payment, #{current_user.username}! You can downgrade your account at any time."
    redirect_to edit_user_registration_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  private

  def amount_to_be_charged
    @amount = 19_99
  end
end

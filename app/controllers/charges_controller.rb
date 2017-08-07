class ChargesController < ApplicationController
  before_action :amount_to_be_charged
  before_action :description

  def new
    @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: @description,
        email: current_user.email,
        amount: @amount
    }
  end

  def create
    customer = StripeService.new(
      email: current_user.email,
      source: params[:stripeToken]
    ).create_customer

    charge = StripeService.new(
      customer_id: customer.id,
      amount: @amount,
      description: @description,
      currency: 'usd'
    ).create_charge

    current_user.update(role:'premium')
    flash[:notice] = "Thank you for you payment, #{current_user.username}! You can downgrade your account at any time."
    redirect_to receipt_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def receipt
  end

  private
  def amount_to_be_charged
    @amount = 19_99
  end

  def description
    @description = "BlocipediaMembership - #{current_user.username}"
  end

end

require 'stripe'

class StripeService
  def initialize(params)
    @customer_id = params[:customer_id]
    @amount = params[:amount]
    @description = params[:description]
    @email = params[:email]
    @source = params[:source]
  end

  def create_charge
    external_charge_service.create(charge_attributes)
  end

  def create_customer
    external_customer_service.create(customer_attributes)
  end

  private

  attr_reader :customer_id, :amount, :description, :email

  def external_charge_service
    Stripe::Charge
  end

  def external_customer_service
    Stripe::Customer
  end

  def charge_attributes
    {
      customer: customer_id,
      amount: amount,
      description: description,
      currency: 'usd'
    }
  end

  def customer_attributes
    {
      email: email,
      source: @source,
    }
  end
end

class CheckoutController < ApplicationController
  def create
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: 'MyResidencyList',
        amount: 9900,
        currency: 'usd',
        quantity: 1
      }],
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url
    )

    respond_to do |format|
      format.js
    end
  end

  def success;
    flash[:notice] = 'Thank You for upgrading! All lists have been unlocked'
    redirect_to root_path
  end

  def cancel; end
end

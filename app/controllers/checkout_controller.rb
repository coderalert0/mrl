class CheckoutController < ApplicationController
  def create
    ahoy.track('User attempted to upgrade')

    send_upgrade_email if current_user.attempts_to_upgrade.size == 1

    @session = Stripe::Checkout::Session.create(
      customer_email: current_user.email,
      payment_method_types: ['card'],
      line_items: [{
        name: 'MyResidencyList',
        description: 'Includes access to ALL 7 speciality lists (FM, IM, Neurological Surgery, Neurology, Peds, Psych, IM/Peds), valid for all matches in the future.
                      Programs database is updated every match season',
        amount: 5900,
        currency: 'usd',
        quantity: 1
      }],
      payment_intent_data: {
        metadata: {
          id: current_user.id,
          name: "#{current_user.first_name} #{current_user.last_name}",
          email: current_user.email,
          sign_in_count: current_user.sign_in_count,
          step_1_score: current_user.step_1_score,
          step_2ck_score: current_user.step_2ck_score,
          img_type: I18n.t(current_user.img_type, scope: :img_types)
        }
      },
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url
    )

    respond_to do |format|
      format.js
    end
  end

  def send_upgrade_email
    UserMailer.with(user: current_user).upgrade.deliver_later
  end

  def success
    if current_user.update(paid: true)
      ahoy.track('User upgraded')

      flash[:notice] = 'Thank You for upgrading! All lists have been unlocked'
      redirect_to root_path
    else
      ahoy.track('Error upgrading')

      flash[:notice] = 'An error occurred'
    end
  end

  def cancel
    ahoy.track('User cancelled upgrade')

    current_user.update(cancelled: true)
    redirect_to root_path
  end
end

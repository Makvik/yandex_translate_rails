class WelcomeController < ApplicationController
  def create
  begin
    @subscription = Actors::Customer::UseCases.subscribe_to_a_plan(current_user.email,
                                                                   params[:stripeToken],
                                                                   params[:plan_name],
                                                                   logger)
  rescue Striped::CreditCardDeclined => e
    redisplay_form(e.message)
  rescue Striped::CreditCardException, Exception => e
    redisplay_form("Subscription failed. We have been notified about this problem.")
  end

end
end

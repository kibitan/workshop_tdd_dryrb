require 'dry/transaction'

class UserOnboardingTransaction
  include Dry::Transaction

  step :validate_email
  step :persist_user

  def validate_email(input)
    email = input[:email]
    return Failure(:email_missing) if email.empty?

    Success(email)
  end

  def persist_user(email)
    Success({ success: true, email: email })
  end
end

require 'dry/transaction'

class UserOnboardingTransaction
  include Dry::Transaction

  step :validate_email

  def validate_email(input)
    email = input[:email]
    return Failure(:email_missing) if email.empty?

    Success(email)
  end
end

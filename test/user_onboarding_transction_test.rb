require 'test_helper'
require 'user_onboarding_transaction'

class UserOnboardingTransactionTest < Minitest::Test
  def test_validate_input
    transaction = UserOnboardingTransaction.new
    result = transaction.call(input: {})

    assert_equal result.class, Dry::Monads::Result::Failure
  end
end

require 'test_helper'
require 'user_onboarding_transaction'

class UserOnboardingTransactionTest < Minitest::Test
  def test_validate_email_success
    transaction = UserOnboardingTransaction.new

    result = transaction.call(email: 'test@test.com')
    assert result.success?
  end

  def test_validate_email_empty
    transaction = UserOnboardingTransaction.new

    result = transaction.call(email: '')
    assert_equal result.success?, false

    assert_equal result.failure, :email_missing
  end
end

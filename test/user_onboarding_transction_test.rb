require 'test_helper'
require 'user_onboarding_transaction'

class UserOnboardingTransactionTest < Minitest::Test
  def test_success_flow
    transaction = UserOnboardingTransaction.new

    result = transaction.call(email: 'test@test.com')
    assert result.success?

    success_records = result.value![:success_records]
    assert_equal success_records.size, 1
    assert_equal success_records.first.class, User
    assert_equal success_records.first.email, 'test@test.com'
  end

  def test_validate_email_empty
    transaction = UserOnboardingTransaction.new

    result = transaction.call(email: '')
    assert_equal result.success?, false
    assert_equal result.failure, :email_missing
  end

end

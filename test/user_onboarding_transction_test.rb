require 'test_helper'
require 'user_onboarding_transaction'
require 'dry/container/stub'

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

  def test_failed_to_persist_user
    Container.enable_stubs!
    Container.stub(:user_repository, ConnectionErrorUserRepository.new)

    transaction = UserOnboardingTransaction.new

    result = transaction.call(email: 'test@test.com')
    assert_equal result.success?, false
    assert_equal result.failure, :connection_error
    Container.unstub
  end

  class ConnectionErrorUserRepository
    def save!(user)
      raise ::UserRepository::ConnectionError
    end
  end
end

require 'dry/transaction'
require 'dry/container'
require_relative 'user'

class Container
  extend Dry::Container::Mixin
end
class UserRepository
  def self.save!(user)
    true
  end

  class ConnectionError < StandardError; end
end

Container.register(:user_repository, UserRepository)

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
    user = User.new(email)
    storage = Container.resolve(:user_repository)
    storage.save!(user)
    Success({success_records: [user] })
  rescue ::UserRepository::ConnectionError
    Failure(:connection_error)
  end
end

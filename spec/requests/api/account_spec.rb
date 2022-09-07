require 'swagger_helper'

RSpec.describe 'api/account', type: :request do
  path '/accounts/{id}/transfer' do

    post 'Transfer money using email OR phone number (pass either phone number or email it will work)' do
      tags 'Accounts'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :customer, in: :body, schema: {
        type: :object,
        properties: {
          receiver_email: { type: :string },
          receiver_phone_number: {type: :string},
          amount: { type: :integer }   
        },
        required: [ 'id','email', 'amount' ]
      }

      response '200', 'Transaction Successful' do
        let(:id) {Account.create(email: 'foo@gmail.com', first_name: 'Foo', last_name: 'Bar',
          phone_number: '+923459090909', status: 1, balance_cents: 100).id }
        run_test!
      end

      response '403', 'Transaction failure for non verified account' do
        let(:id) {Account.create(email: 'foo@gmail.com', first_name: 'Foo', last_name: 'Bar',
          phone_number: '+923459090909', status: -1, balance_cents: 100).id }
        run_test!
      end
    end
  end

  path '/accounts/{id}/transactions_history' do

    get 'Fetch your account transactions history' do
      tags 'Accounts'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Transactions' do
        run_test!
      end
    end
  end
end

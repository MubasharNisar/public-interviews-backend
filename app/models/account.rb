# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id               :bigint           not null, primary key
#  balance_cents    :integer          default(0), not null
#  balance_currency :string           default("USD"), not null
#  email            :string
#  first_name       :string
#  last_name        :string
#  phone_number     :string
#  status           :integer          default("pending"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_accounts_on_email         (email)
#  index_accounts_on_phone_number  (phone_number)
#  index_accounts_on_status        (status)
#
class Account < ApplicationRecord
  validates :first_name, :last_name, :email, :phone_number, presence: true

  has_many :transactions

  monetize :balance_cents, numericality: { greater_than_or_equal_to: 0 }

  enum status: {
    unverified: -1,
    pending: 0,
    verified: 1
  }, _suffix: true

  def apply_transactions(receiver_account, amount)
    with_lock do
      sender_transaction = transactions.create!(
        from_account: self,
        to_account: receiver_account,
        amount_cents: amount,
        transaction_type: Transaction.transaction_types[:debit]
      )

      receiver_account.transactions.create!(
        from_account: self,
        to_account: receiver_account,
        amount_cents: amount,
        transaction_type: Transaction.transaction_types[:credit]
      )

      sender_transaction
    end
  end
end

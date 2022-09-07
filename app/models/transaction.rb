# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  amount_cents     :integer          default(0), not null
#  amount_currency  :string           default("USD"), not null
#  transaction_type :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  account_id       :bigint
#  from_account_id  :bigint
#  to_account_id    :bigint
#
# Indexes
#
#  index_transactions_on_account_id       (account_id)
#  index_transactions_on_from_account_id  (from_account_id)
#  index_transactions_on_to_account_id    (to_account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (from_account_id => accounts.id)
#  fk_rails_...  (to_account_id => accounts.id)
#
class Transaction < ApplicationRecord

  belongs_to :account
  belongs_to :from_account, class_name: 'Account', optional: true
  belongs_to :to_account, class_name: 'Account', optional: true

  validate :check_account_balance
  after_commit :update_balance

  enum transaction_type: {
    debit: 0,
    credit: 1
  }, _suffix: true


  def check_account_balance
    if debit_transaction_type? && (account.balance.fractional - amount_cents).negative?
      errors.add(:base,
                 "You don't have sufficient balance in your account for this transaction")
    end
  end

  def update_balance
    if debit_transaction_type?
      with_lock do
        account.update_column(:balance_cents, account.balance_cents - amount_cents)
      end
    else
      with_lock do
        account.update_column(:balance_cents, account.balance_cents + amount_cents)
      end
    end
  end
end

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
FactoryBot.define do
  factory :transaction do
    
  end
end

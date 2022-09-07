class AddToAccountAndFromAccountToTransaction < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :from_account, foreign_key: { to_table: :accounts }, null: true
    add_reference :transactions, :to_account, foreign_key: { to_table: :accounts }, null: true
  end
end

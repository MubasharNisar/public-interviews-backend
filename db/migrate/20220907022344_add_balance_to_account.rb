class AddBalanceToAccount < ActiveRecord::Migration[6.0]
  def change
    add_monetize :accounts, :balance, null: false, default: 0
  end
end

class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :aasm_state, :default => 'pending'

      t.timestamps
    end
  end
end

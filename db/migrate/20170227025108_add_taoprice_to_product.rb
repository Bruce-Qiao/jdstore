class AddTaopriceToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :taoprice, :integer
  end
end

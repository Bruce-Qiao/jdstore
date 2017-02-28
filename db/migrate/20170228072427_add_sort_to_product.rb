class AddSortToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :sort, :string
  end
end

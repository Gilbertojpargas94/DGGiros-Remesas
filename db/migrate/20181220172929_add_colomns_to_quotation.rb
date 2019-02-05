class AddColomnsToQuotation < ActiveRecord::Migration[5.2]
  def change
    add_column :quotations, :address_user, :string
    add_column :quotations, :dni_user, :string
  end
end

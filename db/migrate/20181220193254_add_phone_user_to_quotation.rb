class AddPhoneUserToQuotation < ActiveRecord::Migration[5.2]
  def change
    add_column :quotations, :phone_user, :string
  end
end

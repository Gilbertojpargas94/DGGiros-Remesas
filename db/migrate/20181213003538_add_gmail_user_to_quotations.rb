class AddGmailUserToQuotations < ActiveRecord::Migration[5.2]
  def change
    add_column :quotations, :gmail_user, :string, default: ''
  end
end

class ChangeGmailToQuotations < ActiveRecord::Migration[5.2]
  def up
    change_table :quotations do |t|
      t.change :gmail_account, :string, null: true, default: ""
      t.change :id_account, :string, null: true, default: ""
    end
  end
 
  def down
    change_table :quotations do |t|
      t.change :gmail_account, :string, null: false, default: ""
      t.change :id_account, :string, null: false, default: ""
    end
  end
end

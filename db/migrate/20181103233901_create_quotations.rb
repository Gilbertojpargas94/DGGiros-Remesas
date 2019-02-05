class CreateQuotations < ActiveRecord::Migration[5.2]
  def change
    create_table :quotations do |t|
      t.references :user, foreign_key: true, null: false
      t.string :order, null: false
      t.float :amount, null: false, default: 0.0
      t.float :rate, null: false, default: 0.0
      t.string :account, null: false, default: ""
      t.string :country, null: false, default: ""
      t.string :bank, null: false, default: ""
      t.string :headline_account, null: false, default: ""
      t.string :id_account, null: false, default: ""
      t.string :gmail_account, null: false, default: ""
      t.string :status, null: false, default: "Esperando Depósito"

      t.timestamps
    end
  end
end

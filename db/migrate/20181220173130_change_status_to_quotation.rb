class ChangeStatusToQuotation < ActiveRecord::Migration[5.2]
  def up
    change_table :quotations do |t|
      t.change :status, :string, null: false, default: "Esperando Comprobante"
    end
  end
 
  def down
    change_table :quotations do |t|
      t.change :status, :string, null: false, default: "Esperando Depósito"
    end
  end
end

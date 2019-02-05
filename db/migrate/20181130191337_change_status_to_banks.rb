class ChangeStatusToBanks < ActiveRecord::Migration[5.2]
  def up
    change_table :banks do |t|
      t.change :status, :boolean, default: true, null: true
    end
  end
 
  def down
    change_table :banks do |t|
      t.change :status, :boolean, default: true, null: false
    end
  end
end

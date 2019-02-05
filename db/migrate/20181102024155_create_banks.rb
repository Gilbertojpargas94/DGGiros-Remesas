class CreateBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :banks do |t|
      t.string :name, null: false, default: ""
      t.string :headline, null: false, default: ""
      t.boolean :status, default: true, null: false

      t.timestamps
    end
  end
end

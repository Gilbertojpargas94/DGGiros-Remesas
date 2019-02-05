class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.string :country, null: false, default: ""
      t.float :value, null: false, default: 0.0

      t.timestamps
    end
  end
end

class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :type, :type_person
  end
end

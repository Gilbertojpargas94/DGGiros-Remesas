class AddPaymentToQuotations < ActiveRecord::Migration[5.2]
  def change
    add_attachment :quotations, :payment
  end
end

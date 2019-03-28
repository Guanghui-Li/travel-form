class CreateWishes < ActiveRecord::Migration[5.1]
  def change
    create_table :wishes do |t|
      t.integer :expense_type_id
      t.decimal :cost
      t.integer :authorization_form_id

      t.timestamps
    end
  end
end

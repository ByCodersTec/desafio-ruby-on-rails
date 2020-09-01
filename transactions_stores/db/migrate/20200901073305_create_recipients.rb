class CreateRecipients < ActiveRecord::Migration[6.0]
  def change
    create_table :recipients do |t|
      t.string :cpf
      t.string :card

      t.timestamps
    end
  end
end

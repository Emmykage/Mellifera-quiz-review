class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.text :content
      t.integer :parent_message_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

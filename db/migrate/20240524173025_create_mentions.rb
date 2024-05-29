class CreateMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :mentions do |t|
      t.string :text
      t.references :user, foreign_key: { to_table: :users }
      t.references :mentioned_user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end

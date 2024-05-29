class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :descr
      t.integer :count_pages
      t.boolean :status

      t.references :user, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.references :deal, null: true, foreign_key: true
    end
  end
end

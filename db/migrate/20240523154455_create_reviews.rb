class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|

      t.string "title"
      t.string "descr"
      t.timestamps
      t.references :user, null: false, foreign_key: true
    end
  end
end

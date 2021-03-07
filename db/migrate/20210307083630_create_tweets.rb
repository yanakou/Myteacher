class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :title
      t.text :text
      t.string :image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

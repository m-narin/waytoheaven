class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string :name, null: false, default: "名無しさん"
      t.string :title, null: false, default: ""
      t.text :content, null: false
      t.string :category, null: false
      t.integer :deletekey, null: false
      t.timestamps
    end
  end
end

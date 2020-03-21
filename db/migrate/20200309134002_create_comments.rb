class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :name, null: false, default: "名無しさん"
      t.string :content, null: false
      t.references :tweet, foreign_key: true
      t.timestamps
    end
  end
end

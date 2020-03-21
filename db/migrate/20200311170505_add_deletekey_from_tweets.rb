class AddDeletekeyFromTweets < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :deletekey, :string
  end
end

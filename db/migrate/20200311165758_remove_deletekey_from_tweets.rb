class RemoveDeletekeyFromTweets < ActiveRecord::Migration[5.1]
  def change
    remove_column :tweets, :deletekey, :integer
  end
end

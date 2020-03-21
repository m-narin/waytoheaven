class AddHellnumberToTweets < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :hellnumber, :integer
  end
end

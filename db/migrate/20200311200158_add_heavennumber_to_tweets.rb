class AddHeavennumberToTweets < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :heavennumber, :integer
  end
end

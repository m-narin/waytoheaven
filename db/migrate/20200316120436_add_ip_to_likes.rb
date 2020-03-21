class AddIpToLikes < ActiveRecord::Migration[5.1]
  def change
    add_column :likes, :ip, :string
  end
end

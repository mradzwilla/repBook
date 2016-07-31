class AddPoliticiansFollowingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :politicians_following, :text
  end
end

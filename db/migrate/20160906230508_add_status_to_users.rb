class AddStatusToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :status, :string
  	add_column :users, :dating_pref, :text
  	remove_column :users, :non_negotiables, :text
  end
end

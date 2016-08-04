class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :is_female, :boolean, default: false
    add_column :users, :height, :integer
    add_column :users, :church, :string
    add_column :users, :church_status, :string
    add_column :users, :interests, :text
    add_column :users, :testimony, :text
    add_column :users, :more_info, :text
    add_column :users, :non_negotiables, :text
    add_column :users, :cellphone, :string
  end
end

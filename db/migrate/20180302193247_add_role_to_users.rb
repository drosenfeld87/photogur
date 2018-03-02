class AddRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table do |t|
      t.belongs_to :user
    end
  end
end

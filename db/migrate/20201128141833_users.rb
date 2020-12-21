class Users < ActiveRecord::Migration[6.0]
  def up
    drop_table :users
  end

  def down
  end
end

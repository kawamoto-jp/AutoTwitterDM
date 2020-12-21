class AddDetailsToSendInfos < ActiveRecord::Migration[6.0]
  def up
    add_column :send_infos, :atena, :string
  end

  def down
  end
end

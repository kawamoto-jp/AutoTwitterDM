class AddDetailsToSendInfos < ActiveRecord::Migration[6.0]
  def change
    add_column :send_infos, :atena, :string
  end
end

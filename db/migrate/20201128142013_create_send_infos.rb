class CreateSendInfos < ActiveRecord::Migration[6.0]
  def up
    create_table :send_infos do |t|
      t.string :name, null: false
      t.text   :text, null: false
      t.timestamps
    end
  end

  def dowm
  end
end

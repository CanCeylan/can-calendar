class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :rType

      t.timestamps
    end
  end
end

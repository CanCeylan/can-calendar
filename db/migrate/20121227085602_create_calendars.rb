class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.integer :resource_id

      t.timestamps
    end
  end
end

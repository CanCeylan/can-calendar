class AddColorColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :color, :string
  end
end

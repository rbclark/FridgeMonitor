class CreateTemperatures < ActiveRecord::Migration[5.2]
  def change
    create_table :temperatures do |t|
      t.float :temperature
      t.string :location
      t.timestamp
    end
  end
end

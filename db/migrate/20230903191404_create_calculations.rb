class CreateCalculations < ActiveRecord::Migration[7.0]
  def change
    create_table :calculations do |t|
      t.decimal :mass, precision: 15, scale: 4
      t.decimal :gravity, precision: 15, scale: 4
      t.decimal :fuel_required, precision: 15, scale: 4
      t.string :title
      t.jsonb :directives, default: {}

      t.timestamps
    end
  end
end

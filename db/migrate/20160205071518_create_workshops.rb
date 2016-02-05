class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.integer :year
      t.string :semester
      t.string :name
      t.timestamps null: false
    end
  end
end

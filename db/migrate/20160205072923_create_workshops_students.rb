class CreateWorkshopsStudents < ActiveRecord::Migration
  def change
    create_table :workshops_students do |t|
      t.integer :workshop_id
      t.integer :unmid

      t.timestamps null: false
    end
  end
end

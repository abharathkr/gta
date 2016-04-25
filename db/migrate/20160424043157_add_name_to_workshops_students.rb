class AddNameToWorkshopsStudents < ActiveRecord::Migration
  def change
    add_column :workshops_students, :name, :string
  end
end

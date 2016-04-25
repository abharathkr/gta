class AddEmailToWorkshopsStudents < ActiveRecord::Migration
  def change
    add_column :workshops_students, :email, :string
  end
end

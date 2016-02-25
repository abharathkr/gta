class CreateStudentcourses < ActiveRecord::Migration
  def change
    create_table :studentcourses do |t|
      t.integer :course1year
      t.string :course1sem
      t.integer :course2year
      t.string :course2sem
      t.belongs_to :student
      t.timestamps null: false
    end
  end
end

class CreateStudentworkshops < ActiveRecord::Migration
  def change
    create_table :studentworkshops do |t|
      t.integer :y1
      t.string :s1
      t.string :n1
      t.integer :y2
      t.string :s2
      t.string :n2
      t.integer :y3
      t.string :s3
      t.string :n3
      t.integer :y4
      t.string :s4
      t.string :n4
      t.belongs_to :student
      t.timestamps null: false
    end
  end
end

class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :unmid
      t.string :email
      t.string :name

      t.timestamps null: false
    end
  end
end

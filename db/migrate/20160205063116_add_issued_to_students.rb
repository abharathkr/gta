class AddIssuedToStudents < ActiveRecord::Migration
  def change
    add_column :students, :issued, :boolean
  end
end

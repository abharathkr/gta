class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
  	@students = Student.all
  end

  def move
  	@stu = Student.find_by(id: params["id"])
  	@stu.issued = true
  	@stu.save
  	redirect_to admin_index_path
  end

  def workshops
  	@workshops = Workshop.all
  end

  def addworkshop
  	if @workshop = Workshop.create(workshop_params)
  		flash[:notice] = "Workshop created"
  	else
  		flash[:notice] = "Workshop not created"
  	end

  	respond_to do |format|
  		format.html { redirect_to admin_workshops_path }
  		format.js { render @workshop }
  	end

  end

  def students
  	@students = WorkshopsStudent.all
  end

  def editstudents
  	@ws_id = params[:id]
  	@ws = Workshop.find_by(id: @ws_id)
  	@currentstudents = WorkshopsStudent.where(workshop_id: params[:id])
  end

  def addstudent
  	if @student = WorkshopsStudent.create(student_params)
  		flash[:notice] = "Student created"
  	else
  		flash[:notice] = "Student not created"
  	end
  	redirect_to admin_editstudents_path(:id => @student.workshop_id)
  end

  private
  
  def workshop_params
    params.permit(:year , :semester , :name )
  end

  def student_params
    params.permit(:workshop_id , :unmid )
  end

end
class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
  	@pendingstudents = Student.where(issued: 'f')
    @issuedstudents = Student.where(issued: 't').order("id desc").limit(20)
  end

  def list
    @students = Student.where(issued: 't')
  end

  def move
  	@stu = Student.find_by(id: params["id"])
  	@stu.issued = true
  	@stu.save
    redirect_to admin_index_path
  end

  def moveback
    @stu = Student.find_by(id: params["id"])
    @stu.issued = false
    @stu.save
    redirect_to admin_index_path
  end

  def workshops
  	@workshops = Workshop.all.order("year desc")
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

  def deletestudent
    @stu = Student.find_by(id: params["id"])
    @stu.destroy
    redirect_to admin_index_path    
  end

  def deleteworkshop
    @wsp = Workshop.find_by(id: params["id"])
    @wsp.destroy
    redirect_to admin_workshops_path    
  end

  def geditworkshop
    @workshop = Workshop.find_by(id: params["id"])
    @sems = ["Fall","Summer","Spring"]
  end

  def editworkshop
    @wsp = Workshop.find_by(id: editworkshop_params[:id])
    @wsp.name = editworkshop_params[:name]
    @wsp.year = editworkshop_params[:year]
    @wsp.semester = editworkshop_params[:semester]
    @wsp.save
    redirect_to admin_workshops_path
  end

  private
  
  def workshop_params
    params.permit(:year , :semester , :name )
  end

  def student_params
    params.permit(:workshop_id, :unmid, :name, :email )
  end

  def editworkshop_params
    params.permit(:id,:year,:semester,:name)
  end

end
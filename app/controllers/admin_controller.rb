class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
  	@pendingstudents = Student.where(issued: 'f')
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

  def workstudentslist
  	@ws_id = params[:id]
  	@ws = Workshop.find_by(id: @ws_id)
  	@currentstudents = WorkshopsStudent.where(workshop_id: params[:id]).order("id desc")
  end

  def addstudent
    if WorkshopsStudent.exists?(:workshop_id => student_params[:workshop_id],:unmid => student_params[:unmid])
      flash.now[:error] = "You already added this student to this worksop. Please add a new one"
      @ws_id = student_params[:workshop_id]
      @ws = Workshop.find_by(id: @ws_id)
      @currentstudents = WorkshopsStudent.where(workshop_id: student_params[:workshop_id]).order("id desc")
      #redirect_to admin_workstudentslist_path(:id => student_params[:workshop_id])
      render action: "workstudentslist"
    else 
    	if @student = WorkshopsStudent.create(student_params)
    		flash[:notice] = "Student created"
    	else
    		flash[:notice] = "Student not created"
    	end
    	redirect_to admin_workstudentslist_path(:id => @student.workshop_id)
    end
  end

  def deletestudent
    @stu = Student.find_by(id: params["id"])
    @stu.destroy
    redirect_to admin_index_path    
  end

  def deleteworkshop
    @wsp = Workshop.find_by(id: params["id"])
    @stus = WorkshopsStudent.where(:workshop_id => @wsp.id)
    @stus.destroy_all
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

  def geditworkstudent
    @workstudent = WorkshopsStudent.find_by(id: params[:id])
    @worksid = params[:wsid]
  end

  def editworkstudent
    @ws = WorkshopsStudent.find_by(id: editworkstudent_params[:id])
    @ws.name = editworkstudent_params[:name]
    @ws.email = editworkstudent_params[:email]
    @ws.unmid = editworkstudent_params[:unmid]
    @ws.save
    redirect_to admin_workstudentslist_path(:id => editworkstudent_params[:wsid])
  end

  def deleteworkstudent
    @stu = WorkshopsStudent.find_by(id: params["id"])
    @stu.destroy
    redirect_to admin_workstudentslist_path(:id => params["wsid"])
  end

  def spage
  end

  def search
    @student = Student.find_by(unmid: search_params[:unmid])
    if @student
      @studentcourses = Studentcourse.where(student_id: @student.id)
      @studentworkshops = Studentworkshop.find_by(student_id: @student.id)
      @workshops = WorkshopsStudent.where(:unmid => @student.unmid)
    else
      @workshops = WorkshopsStudent.where(:unmid => search_params[:unmid])
    end
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

  def editworkstudent_params
    params.permit(:id,:unmid,:email,:name,:wsid)
  end

  def search_params
    params.permit(:unmid)
  end

end
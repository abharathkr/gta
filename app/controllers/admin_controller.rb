class AdminController < ApplicationController

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

  def createworkshop
  end

  def addworkshop
  	if @workshop = Workshop.create(workshop_params)
  		flash[:notice] = "Workshop created"
  	else
  		flash[:notice] = "Workshop not created"
  	end
  	redirect_to admin_index_path
  end

  private
  
  def workshop_params
    params.permit(:year , :semester , :name )
  end

end
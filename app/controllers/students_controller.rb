class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  def search
    @search_student = Student.find_by(unmid: params[:search])
    @student = Student.new
    @workshopnames = Workshop.pluck(:name, :year, :semester)
  end

  # GET /students/new
  def new
    if admin_signed_in?
      redirect_to admin_index_path
    end
    @student = Student.new
    @workshopnames = Workshop.pluck(:name)
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @ss = 0 #using this variable for sending file path after the file is saved
    @student = Student.new(student_params)
    @student.issued = false
    @studentcourses = Studentcourse.new(student_courses_params(:studentcourse))
    @studentworkshops = Studentworkshop.new(studentworkshops_params)
    respond_to do |format|
      if @student.save
        @studentcourses.student_id = @student.id
        @studentcourses.save
        @studentworkshops.student_id = @student.id
        @studentworkshops.save
        @ss = 1
        print "hello"
        print @studentcourses.course2.path
        print "hello"
        format.html { redirect_to students_applicationfinished_path, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
    if @ss == 1
      cid = @studentcourses.id
      @sss = Studentcourse.find_by(id: cid)
      #AdminMailer.success_mail('reddysbharath@gmail.com',@studentcourses.course1.path).deliver_later
      print "hello"
      print cid
      print @studentcourses.course2.path
      print "hello"
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def attendance
    @stdid = params[:student_id]    
  end

  def attendances
    @student_id = params[:student_id]
    @studentworkshops = Studentworkshop.where(:student_id => params[:student_id])
  end

  def studentworkshops
    @studentworkshop = Studentworkshop.create(studentworkshops_params)
    redirect_to students_attendances_path(:student_id => studentworkshops_params[:student_id])
  end

  def applicationfinished
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.permit(:unmid, :email, :name)
    end

    def student_courses_params
      params.require(:studentcourse).permit(:course1year, :course1sem, :course2year, :course2sem, :course1, :course2, :teachexp)
    end
      #params.permit(:unmid, :email, :name, :course1year, :course1sem, :course2year, :course2sem, :course1, :course2, :teachexp)

    def studentworkshops_params
      params.permit(:y1,:s1,:n1,:n2,:s2,:n2,:y3,:s3,:n3,:y4,:s4,:n4)
    end

end

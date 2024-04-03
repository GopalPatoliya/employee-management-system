class EmployeesController < ApplicationController
  before_action :authenticate_user!, except: [:import_from_api]
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employees = Employee.filtered(params[:department], params[:min_salary], params[:max_salary])

    respond_to do |format|
      format.html
    end
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee, notice: 'Employee was successfully created.'
    else
      render :new
    end
  end

  def update
    if @employee.update(employee_params)
      redirect_to @employee, notice: 'Employee was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @employee.destroy
    redirect_to employees_path, notice: 'Employee was successfully destroyed.'
  end

  def import_from_api
    EmployeeDataImportWorker.perform_async
    redirect_to employees_path, notice: 'Importing employees data.'
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :department, :salary)
  end
end

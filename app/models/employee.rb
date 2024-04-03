class Employee < ApplicationRecord
 
  validates :first_name, :last_name, :email, :department, :salary, presence: true
  validates :email, uniqueness: true

  scope :filtered, ->(department, min_salary, max_salary) {
    employees = all
    employees = employees.where(department: department) if department.present?
    employees = employees.where('salary >= ?', min_salary) if min_salary.present?
    employees = employees.where('salary <= ?', max_salary) if max_salary.present?
    employees
  }

  def self.all_departments
    pluck(:department).uniq.sort
  end
end

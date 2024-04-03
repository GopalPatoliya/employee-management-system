require 'sidekiq'

class EmployeeDataImportWorker
  include Sidekiq::Worker

  def perform
    begin
      employees_data = EmployeeApiService.fetch_employees

      employees_data.each do |employee_data|
        Employee.create!(
          first_name: employee_data['first_name'],
          last_name: employee_data['last_name'],
          email: employee_data['email'],
          department: employee_data['department'],
          salary: employee_data['salary']
        )
      end
    rescue StandardError => e
      Rails.logger.error "Error occurred during employee data import: #{e.message}"
    end
  end
end

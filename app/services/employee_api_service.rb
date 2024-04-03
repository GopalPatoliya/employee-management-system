require 'httparty'

class EmployeeApiService
  include HTTParty
  def self.fetch_employees
    response = HTTParty.get('http://localhost:3000/api/v1/employees')
    
    JSON.parse(response.body)
  end
end

module Api
  module V1
    class EmployeesController < ApplicationController
      def index
        employees = []
        10.times do
          employee = {
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.email,
            department: Faker::Company.profession,
            salary: Faker::Number.between(from: 30000, to: 100000)
          }
          employees << employee
        end
        render json: employees
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:department) }
    it { should validate_presence_of(:salary) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'scopes' do
    describe '.filtered' do
      let!(:employee1) { create(:employee, department: 'IT', salary: 50000) }
      let!(:employee2) { create(:employee, department: 'HR', salary: 60000) }
      let!(:employee3) { create(:employee, department: 'IT', salary: 70000) }

      it 'returns employees with the specified department' do
        expect(Employee.filtered('IT', nil, nil)).to eq([employee1, employee3])
      end

      it 'returns employees with salary greater than or equal to the specified minimum salary' do
        expect(Employee.filtered(nil, 60000, nil)).to eq([employee2, employee3])
      end

      it 'returns employees with salary less than or equal to the specified maximum salary' do
        expect(Employee.filtered(nil, nil, 60000)).to eq([employee1, employee2])
      end

      it 'returns employees with both specified department and salary range' do
        expect(Employee.filtered('IT', 50000, 70000)).to eq([employee1, employee3])
      end

      it 'returns all employees when no filters are provided' do
        expect(Employee.filtered(nil, nil, nil)).to eq([employee1, employee2, employee3])
      end
    end
  end

  describe '.all_departments' do
    before do
      create(:employee, department: 'IT')
      create(:employee, department: 'HR')
      create(:employee, department: 'IT')
    end

    it 'returns an array of all unique departments' do
      expect(Employee.all_departments).to contain_exactly('IT', 'HR')
    end
  end
end

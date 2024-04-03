require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  let(:valid_attributes) do
    {
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@example.com',
      department: 'IT',
      salary: 50000
    }
  end

  let(:invalid_attributes) do
    {
      first_name: nil,
      last_name: nil,
      email: nil,
      department: nil,
      salary: nil
    }
  end

  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all employees as @employees' do
      employee = create(:employee)
      get :index
      expect(assigns(:employees)).to eq([employee])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'assigns the requested employee as @employee' do
      employee = create(:employee)
      get :show, params: { id: employee.id }
      expect(assigns(:employee)).to eq(employee)
    end

    it 'renders the show template' do
      employee = create(:employee)
      get :show, params: { id: employee.id }
      expect(response).to render_template('show')
    end
  end

  describe 'GET #new' do
    it 'assigns a new employee as @employee' do
      get :new
      expect(assigns(:employee)).to be_a_new(Employee)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Employee' do
        expect {
          post :create, params: { employee: valid_attributes }
        }.to change(Employee, :count).by(1)
      end

      it 'redirects to the created employee' do
        post :create, params: { employee: valid_attributes }
        expect(response).to redirect_to(Employee.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Employee' do
        expect {
          post :create, params: { employee: invalid_attributes }
        }.not_to change(Employee, :count)
      end

      it 're-renders the new template' do
        post :create, params: { employee: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested employee as @employee' do
      employee = create(:employee)
      get :edit, params: { id: employee.id }
      expect(assigns(:employee)).to eq(employee)
    end

    it 'renders the edit template' do
      employee = create(:employee)
      get :edit, params: { id: employee.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) { { first_name: 'Jane' } }

    context 'with valid params' do
      it 'updates the requested employee' do
        employee = create(:employee)
        put :update, params: { id: employee.id, employee: new_attributes }
        employee.reload
        expect(employee.first_name).to eq('Jane')
      end

      it 'redirects to the employee' do
        employee = create(:employee)
        put :update, params: { id: employee.id, employee: new_attributes }
        expect(response).to redirect_to(employee)
      end
    end

    context 'with invalid params' do
      it 'does not update the employee' do
        employee = create(:employee)
        put :update, params: { id: employee.id, employee: invalid_attributes }
        expect(assigns(:employee)).to eq(employee)
      end

      it 're-renders the edit template' do
        employee = create(:employee)
        put :update, params: { id: employee.id, employee: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested employee' do
      employee = create(:employee)
      expect {
        delete :destroy, params: { id: employee.id }
      }.to change(Employee, :count).by(-1)
    end

    it 'redirects to the employees list' do
      employee = create(:employee)
      delete :destroy, params: { id: employee.id }
      expect(response).to redirect_to(employees_url)
    end
  end
end

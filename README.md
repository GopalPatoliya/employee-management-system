# Employee Management System

Welcome to the Employee Management System!

## Description

This is a web application built with Ruby on Rails for managing employee records. It allows users to perform CRUD (Create, Read, Update, Delete) operations on employee data.

## Features

- View a list of all employees
- Add a new employee
- Edit existing employee details
- Delete an employee record
- Import employees through external API
- Filter employees based on salary and department

# Before you begin, ensure you have met the following requirements:

- Ruby
- Rails
- sqlite
- redis

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/GopalPatoliya/employee-management-system.git

2. bundle install

3. rails db:create

4. rails db:migrate

5. rails db:seed

6. rails s

7. bundle exec sidekiq (to import data through external api in background jobs )

## Use case

- First you need to sign up or login with the following credentials
    username/email : user1@yopmail.com, password: User@123
- after login user will be redirected to Employee index page where all employees are listed
- On Index page user can create/update/delete employee though given buttons
- Through Import button a user can import and save employees data thorugh API which is created within a project itself
- And logout, login, and sign up options are also there

## Run test cases
- bundle exec rspec 

## To Import data
- A sidekiq must be running 
- bundle exec sidekiq

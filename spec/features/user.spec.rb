require 'rails_helper'
# On the right side of this RSpec.feature, write the test item name like "task management feature" (grouped by do ~ end)
RSpec.feature "User management function", type: :feature do
 # In scenario (alias of it), write the processing of the test for each item you want to check.
   # Task.create!(title: 'Student', content: 'Is a good student')
   # Task.create!(title: 'Accountant', content: 'Balance money')
   background do
     User.create!(fname: "ndikumana",lname: "alexis", email: 'alexis@gmail.com', user_type: 'admin', password: 'alexis')
     visit  root_path
     fill_in  'Email' ,  with: 'alexis@gmail.com'
     fill_in  'Password' ,  with: 'alexis'
     click_on  'Log in'
   end
   scenario "Test number of users" do
    
    User.create!(fname: 'ndikumana', lname: 'alexis', email: 'ale@gmail.com', user_type: 'admin', password: 'alexis')
    @user = User.all.count
    expect(@user).to eq 2
  end
  scenario "Test user list" do
    
    User.create!(fname: 'ndikumana', lname: 'alexis', email: 'ale@gmail.com', user_type: 'admin', password: 'alexis')
    visit admin_users_path
    expect(page ).to  have_content  'alexis'
    expect(page ).to  have_content  'ndikumana'
    expect(page ).to  have_content  'admin'
  end
  scenario "Test user creation" do
    User.create!(fname: 'ndikumana', lname: 'alexis', email: 'ale@gmail.com', user_type: 'admin', password: 'alexis')
    visit admin_users_path
    expect(page ).to  have_content  'alexis'
  end
  scenario "Test user details" do
    @user= User.create!(fname: 'ndikumana', lname: 'alexis', email: 'ale@gmail.com', user_type: 'admin', password: 'alexis')
    visit admin_users_path(id: @user.id)
    expect(page).to have_content('ale@gmail.com')
    expect(page).to have_content('admin')
  end
  scenario "Test task updating" do
    @user=User.create!(fname: 'ndikumana', lname: 'alexis', email: 'ale@gmail.com', user_type: 'admin', password: 'alexis')
    visit users_path
    visit edit_user_path(id: @user.id)
    User.update(fname: 'Prince', lname: 'alexis', email: 'ale@gmail.com', user_type: 'admin', password: 'alexis')
    visit users_path
    expect(page).to have_content('Profile')
  end
  scenario 'Test Task Deletion' do
    @user= User.create!(fname: 'ndikumana', lname: 'alexis', email: 'ale@gmail.com', user_type: 'admin', password: 'alexis')
    @user = User.last
    @user.destroy
    visit users_path
    expect(page).not_to have_content('ndikumana')
  end
end
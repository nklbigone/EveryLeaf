require 'rails_helper'
# On the right side of this RSpec.feature, write the test item name like "task management feature" (grouped by do ~ end)
RSpec.feature "User management function", type: :feature do
 # In scenario (alias of it), write the processing of the test for each item you want to check.
   # Task.create!(title: 'Student', content: 'Is a good student')
   # Task.create!(title: 'Accountant', content: 'Balance money')
   background do
     User.create!(lname: "alexis", email: 'alexis@gmail.com',  password: 'alexis')
     visit  root_path
     fill_in  'Email' ,  with: 'alexis@gmail.com'
     fill_in  'Password' ,  with: 'alexis'
     click_on  'Log in'
   end
   
end
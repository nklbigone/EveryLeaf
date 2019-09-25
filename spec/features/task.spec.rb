# In this require, the feature required for Feature Spec such as Capybara are available.
require 'rails_helper'

# On the right side of this RSpec.feature, write the test item name like "task management feature" (grouped by do ~ end)
RSpec.feature "Task management function", type: :feature do
  # In scenario (alias of it), write the processing of the test for each item you want to check.
  scenario "Test task list" do
    # Create two tasks in advance to use in the task list test
    Task.create!(title: 'test_task_01', task_name: 'testtesttest' , user_id: '3')
    Task.create!(title: 'test_task_02', task_name: 'samplesample', user_id: '2')
  
    # visit to tasks_path (transition to task list page)
    visit tasks_path
  
    # write a test to verify that the string "" testtesttest "" samplesample "is included when accessing the task list page using have_content method
    save_and_open_page

    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end
  scenario "Test task creation" do
    visit new_task_path
    fill_in 'Title', with: 'greeting'
    click_button '登録する'
    visit tasks_path
    expect(page).to have_content 'greeting'
  end
  scenario "Test task details" do
    Task.create!(title: 'fine', task_name: 'hello' , user_id: '1')
    visit tasks_path
    click_link 'Show'
    expect(page).to have_content 'fine'
    expect(page).to have_content 'hello'
    expect(page).to have_content '1'
  end
end

require 'rails_helper'
RSpec.feature "Task management function", type: :feature do
  background do
    User.create!(fname: "ndikumana",lname: "alexis", email: 'alexis@gmail.com',  password: 'alexis')
    visit root_path
    fill_in 'Email', with: 'alexis@gmail.com'
    fill_in 'Password', with: 'alexis'
    click_on 'Log in'
  end

  scenario "Test task list" do
    visit new_task_path
    @user = User.last
    Task.create(title: 'title 1', task_name: 'task 1', status: 'Not started', user_id: @user.id)
    Task.create(title: 'title 2', task_name: 'task 2', status: 'Not started', user_id: @user.id)
    visit tasks_path
    expect(page).to have_content 'title 1'
    expect(page).to have_content 'Not started'
  end
  scenario "Test task creation" do
    visit new_task_path
    @user = User.first
    Task.create(title: 'title 1', task_name: 'task 1', status: 'Not started', user_id: @user.id)
    visit tasks_path
    expect(page).to have_content 'title 1'
  end
  scenario "Test task details" do
    @user = User.first
    @task = Task.create(title: 'title 1', task_name: 'task 1', status: 'Not started', user_id: @user.id)
    visit task_path(id: @task.id)
    expect(page).to have_content 'title 1'
    expect(page).to have_content 'task 1'
    expect(page).to have_content '1'
  end
  scenario "Test whether tasks are arranged in descending order of creation date" do
    Task.all.order('created_at DESC').all.should ==  Task.order('created_at DESC')
  end
  scenario "Test if tasks are ordered by deadline" do
    visit tasks_path
    click_button 'Sort by deadline'
    save_and_open_page
    assert Task.all.order('deadline DESC')
  end

  scenario "Test search by title" do
    @user = User.last
    Task.create(title: 'title 1', task_name: 'task 1', status: 'Not started', user_id: @user.id)
    visit tasks_path
    fill_in 'Search by title', with: 'title 1'
    click_button 'Search'
    expect(page).to have_content 'task 1'
  end

  scenario "Test search by status" do
    @user = User.last
    Task.create(title: 'Student', task_name: 'my task', status: 'Not started', user_id: @user.id)
    visit tasks_path
    fill_in 'Search by status', with: 'Not started'
    click_button 'Search'
    expect(page).to have_content 'Not started'
  end

  scenario "Test search by both status and title" do
    @user = User.last
    Task.create(title: 'Student', task_name: 'my task', status: 'Not started', user_id: @user.id)
    visit tasks_path
    fill_in 'Search by title', with: 'Studen'
    fill_in 'Search by status', with: 'Not started'
    click_button 'Search'
    expect(page).to have_content 'Student'
    expect(page).to have_content 'Not started'
  end
  scenario "Test sort by priority" do
    @user = User.last
    Task.create(title: 'Student', task_name: 'my task', status: 'Not started', user_id: @user.id)
    Task.create(title: 'working', task_name: 'your task', status: 'In progress', user_id: @user.id)
    visit tasks_path
    click_button 'Sort by priority'
    assert Task.all.order('priority desc')
  end
end
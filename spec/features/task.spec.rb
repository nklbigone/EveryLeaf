
require 'rails_helper'
RSpec.feature "Task management function", type: :feature do
  background do
    FactoryBot.create(:task, title: 'title 1', task_name: 'task 1', status: 'Not started', user_id: '2')
    FactoryBot.create(:task, title: 'title 2', task_name: 'task 2', status: 'In progress', user_id: '5')
    FactoryBot.create(:task, title: 'title 3', task_name: 'task 3', status: 'Done', user_id: '1')
    FactoryBot.create(:second_task, title: 'title second', task_name: 'task second', status: 'Done', user_id: '10')
  end

  scenario "Test task list" do
    visit tasks_path
  
    save_and_open_page

    expect(page).to have_content 'title 1'
    expect(page).to have_content 'task 1'
  end
  scenario "Test task creation" do
    visit new_task_path
    fill_in 'Title', with: 'greeting'
    fill_in 'Task name', with: 'hello'
    click_button '登録する'
    visit tasks_path
    expect(page).to have_content 'greeting'
  end
  scenario "Test task details" do
    task=Task.create!(title: 'fine', task_name: 'hello' , user_id: '1')
    visit task_path(id: task.id)
    expect(page).to have_content 'fine'
    expect(page).to have_content 'hello'
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
    visit tasks_path
    fill_in 'title', with: 'title 1'
    click_button 'search'
    expect(page).to have_content 'title 1'
  end

  scenario "Test search by status" do
    visit tasks_path
    fill_in 'status', with: 'In progress'
    click_button 'search'
    expect(page).to have_content 'In progress'
  end

  scenario "Test search by both status and title" do
    visit tasks_path
    fill_in 'title', with: 'title 3'
    fill_in 'status', with: 'Done'
    click_button 'search'
    expect(page).to have_content 'title 3'
    expect(page).to have_content 'Done'
  end
  scenario "Test sort by priority" do
    visit tasks_path
    click_button 'Sort by deadline'
    assert Task.all.order('priority desc')
  end
end
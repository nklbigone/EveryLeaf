require 'rails_helper'
RSpec.feature "Label Management Function", type: :feature do
    background do
        User.create!(fname: "ndikumana",lname: "alexis", email: 'alexis@gmail.com',  password: 'alexis')
        visit root_path
        fill_in 'Email', with: 'alexis@gmail.com'
        fill_in 'Password', with: 'alexis'
        click_on 'Log in'
    
    @user = User.first
    FactoryBot.create(:label, title: "label1", content: 'content1', user_id: @user.id)
    FactoryBot.create(:label, title: "label2", content: 'content1', user_id: @user.id)
    FactoryBot.create(:label, title: "label3", content: 'content1', user_id: @user.id)
    FactoryBot.create(:task, title: 'task1',
                             status: 'Not started',
                             task_name: 'content1',
                             priority:'low',
                             start_at: '2019-10-01',
                             end_at: '2019-10-02',
                             user_id: @user.id)
  end
  scenario "Test Label list availability" do
    visit labels_path
    save_and_open_page
    expect(page).to have_content "label1"
  end
  scenario "Test Label creation" do
    visit new_label_path
    fill_in 'Title', with: 'label4'
    click_button "Save"
    expect(page).to have_content 'label4'
  end
  scenario "Test Label attached to task" do
    @task = Task.first
    @label1 = Label.first
    @label2 = Label.second
    @task.labels = [@label1, @label2]
    @task.save
    visit tasks_path
    fill_in "search_label", with: "label1"
    expect(page).to have_content "label1"
  end

end
FactoryBot.define do

    factory :task do
      title { 'testtesttest' }
      task_name { 'samplesample' }
    end
    factory :second_task, class: Task do
      title { 'Default title 2 created by Factory' }
      task_name { 'Default task name 2 created by Factory' }
    end

    
  end
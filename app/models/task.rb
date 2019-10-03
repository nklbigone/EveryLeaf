class Task < ApplicationRecord
    validates :title, presence:true
    validates :task_name, presence:true
    enum priority: [:low, :medium, :high]
end

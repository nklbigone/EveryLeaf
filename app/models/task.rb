class Task < ApplicationRecord
    validates :title, presence:true
    validates :task_name, presence:true
    enum priority: [:low, :medium, :high]
    paginates_per 5
end

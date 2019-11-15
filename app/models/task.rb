class Task < ApplicationRecord
    belongs_to :user
    validates :title, presence:true
    validates :task_name, presence:true
    enum priority: [:low, :medium, :high]
    paginates_per 5

    has_many :task_labels, dependent: :destroy
    has_many :labels, through: :task_labels
end

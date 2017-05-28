class LogAction < ActiveRecord::Base
  belongs_to :user
  belongs_to :action_list
  default_scope -> { order(created_at: :desc) }
  validates :action_list, presence: true
end

class ActionList < ActiveRecord::Base
	has_many :log_actions
	has_many :users, :through => :log_actions
	validates :name, presence: true
end

class User < ActiveRecord::Base
	has_many :log_actions
	has_many :action_lists, :through => :log_actions
	validates :name, presence: true
end

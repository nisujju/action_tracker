class AnalyseAction < ActiveRecord::Base
	default_scope -> { order(:action_name1, :action_name2) }
end

module AnalyseActionsHelper

	def add_analyse(action_name)
		actions= ActionList.pluck(:name)
		actions.delete(action_name)
		actions.each do |action_name2|
			@action_analyse = AnalyseAction.new
			@action_analyse.update_attributes(:action_name1 => action_name, :action_name2 => action_name2, :immediate => 0, :weekly => 0, :monthly => 0, :yearly => 0, :lifetime => 0)
			@action_analyse.save

			@action_analyse1 = AnalyseAction.new
			@action_analyse1.update_attributes(:action_name1 => action_name2, :action_name2 => action_name, :immediate => 0, :weekly => 0, :monthly => 0, :yearly => 0, :lifetime => 0)
			@action_analyse1.save			
		end
	end


	def update_analyse(action)
		created_at = action.created_at
		new_action = ActionList.find(action.action_list_id)
		log_actions = LogAction.where("user_id = ? AND action_list_id != ?", action.user_id, action.action_list_id)
		log_actions.each do |log_action|
			difference = calculate_frequency(created_at, log_action.created_at)
			# analyse_action = AnalyseAction.where("action_name1 = ? AND action_name2 = ?", new_action.name, ActionList.find(log_action.action_list_id).name)
			analyse_action = AnalyseAction.find_by_action_name1_and_action_name2(ActionList.find(log_action.action_list_id).name, new_action.name)
			if difference >= 0 && difference < 1
				analyse_action.immediate += 1
			elsif difference >= 1 && difference <= 7
				analyse_action.weekly += 1
			elsif difference > 7 && difference <= 30
				analyse_action.monthly += 1
			elsif difference > 30 && difference <= 365
				analyse_action.yearly += 1
			else
				analyse_action.lifetime += 1
			end
			analyse_action.save
		end
	end

	def calculate_frequency(created_at_new_action, created_at_old_actions)
		TimeDifference.between(created_at_new_action, created_at_old_actions).in_days
	end


	def extract_action_info(action_name)
		action_output = AnalyseAction.where("action_name1 = ?", action_name).pluck(:action_name2, :immediate, :weekly, :monthly, :yearly, :lifetime)
		sum_of_actions = action_output.transpose.map {|a| a.inject(:+)}
		new_arr = []

		action_output.each do |x|
		  z=[]
		  x.each_with_index do |y, i|
		  	if i == 0
		  	   z[i] = y[i]
		  	elsif sum_of_actions[i] > 0
		  	   z[i] = (((y.to_f)/(sum_of_actions[i].to_f)) * 100) 
		  	else
		  	   z[i] = 0.0
		  	end	  	
		  end
		  new_arr << z
		end
		debugger
		new_arr
		# new_arr.transpose
	end
end

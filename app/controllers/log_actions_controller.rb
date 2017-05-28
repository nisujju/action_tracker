class LogActionsController < ApplicationController

	def log_task
		@action = LogAction.new
		@user = User.find_by_name(params[:name])
		@action.user_id = @user.id
		@action.action_list_id = params[@user.id.to_s][:action_list_id]
		debugger
		if @action.save
		  update_analyse(@action)
	      flash[:success] = "Task added successfully"
	      redirect_to @user
    	else
      	  redirect_to :back
    	end
	end
end

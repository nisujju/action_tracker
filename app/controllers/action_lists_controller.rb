class ActionListsController < ApplicationController
  before_action :set_action_list, only: [:show, :edit, :update, :destroy]

  # GET /action_lists
  # GET /action_lists.json
  def index
    @action_lists = ActionList.all
  end

  # GET /action_lists/1
  # GET /action_lists/1.json
  def show
    @probabilities=extract_action_info(@action_list.name)
  end

  # GET /action_lists/new
  def new
    @action_list = ActionList.new
  end

  # GET /action_lists/1/edit
  def edit
  end

  # POST /action_lists
  # POST /action_lists.json
  def create
    @action_list = ActionList.new(action_list_params)

    respond_to do |format|
      if @action_list.save
        format.html { redirect_to @action_list, notice: 'Action list was successfully created.' }
        format.json { render :show, status: :created, location: @action_list }
        # @analyse_action = AnalyseAction.new
        # debugger
        # @analyse_action.add_analyse(@action_list.name)
        add_analyse(@action_list.name)
        redirect_to action: "index" and return
      else
        format.html { render :new }
        format.json { render json: @action_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /action_lists/1
  # PATCH/PUT /action_lists/1.json
  def update
    respond_to do |format|
      if @action_list.update(action_list_params)
        format.html { redirect_to @action_list, notice: 'Action list was successfully updated.' }
        format.json { render :show, status: :ok, location: @action_list }
      else
        format.html { render :edit }
        format.json { render json: @action_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /action_lists/1
  # DELETE /action_lists/1.json
  def destroy
    @action_list.destroy
    respond_to do |format|
      format.html { redirect_to action_lists_url, notice: 'Action list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_action_list
      @action_list = ActionList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def action_list_params
      params.require(:action_list).permit(:name, :description)
    end
end

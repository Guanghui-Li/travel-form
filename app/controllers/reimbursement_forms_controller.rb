class ReimbursementFormsController < ApplicationController

  before_action :set_reimbursement_form, only: [ :edit, :update, :destroy]
  before_action :set_trip, only: [:show, :new, :edit]

  # GET /reimbursement_forms
  # GET /reimbursement_forms.json
  def index
    @reimbursement_forms = ReimbursementForm.all
  end

  # GET /reimbursement_forms/1
  # GET /reimbursement_forms/1.json
  def show
    @reimbursement_form = ReimbursementForm.find(@trip.reimbursement_form.id)
    @receipts_request = @reimbursement_form.receipts_request
    @requests = @trip.requests
    @total_reimb_budget = 0
    @receipts_request_total = 0
    #@reim_message = ReimFormMessage.where(reimbursement_form_id: @reimbursement_form.id)
  end

  # GET /reimbursement_forms/new
  def new
    @reimbursement_form = ReimbursementForm.new
    @status_id = Status.where(name: "Pending").take.id
  end

  # GET /reimbursement_forms/1/edit
  def edit
  end


  def create_receipts
    @reimbursement_form = ReimbursementForm.find(params[:reimbursement_form])
    @status_id = Status.where(name: "Pending").take.id
    @receipts_request = @reimbursement_form.receipts_request.build
    @receipts = @receipts_request.receipts.build
    @trip = @reimbursement_form.trip
    @message = @trip.reim_form_message.create(trip_id: @trip.id,
                                              status_id: @status_id,
                                              employee_id: current_employee.id)
                                                            
    render 'create_receipts'
  end

  # POST /reimbursement_forms
  # POST /reimbursement_forms.json
  def create
    
    @reimbursement_form = ReimbursementForm.new(reimbursement_form_params)
    @trip = Trip.find(params[:reimbursement_form][:trip_id])

    respond_to do |format|
      if @reimbursement_form.save
        @trip = nil
        format.html { redirect_to create_receipt_yea_path(:reimbursement_form => @reimbursement_form)}
        format.json { render :create_receipts, status: :created, location: @reimbursement_form }
      else
        format.html { render :new }
        format.json { render json: @reimbursement_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reimbursement_forms/1
  # PATCH/PUT /reimbursement_forms/1.json
  def update
    respond_to do |format|
      if @reimbursement_form.update(reimbursement_form_params)
        format.html { redirect_to trip_index_url, notice: 'Reimbursement form was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @reimbursement_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reimbursement_forms/1
  # DELETE /reimbursement_forms/1.json
  def destroy
    @reimbursement_form.destroy
    respond_to do |format|
      format.html { redirect_to trip_index_url, notice: 'Reimbursement form was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reimbursement_form
      @reimbursement_form = ReimbursementForm.find(params[:id])
    end
  
    def set_trip
      @trip = Trip.find(params[:trip_id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    # New Create, need all attribute and table names
    def reimbursement_form_params
      params.require(:reimbursement_form).permit(:status_id, :employee_id, :trip_id, 
      receipts_request_attributes: [:id,:total_amount, :department_id,:status_id, :receipts_request_id,
       receipts_attributes: [:id,:location,:receipt_date,:expense_type_id,:image_url,:cost,:receipts_request_id,:reimbursement_form_id]],
       notification_attributes: [:trip_id,:status_id,:employee_id,:form_id,:form])
    end
    
    
end

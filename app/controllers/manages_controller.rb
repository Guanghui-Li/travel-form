class ManagesController < ApplicationController

#**********Manage Auth Form**********#
    def authform_index

        if PaymentManager.where(employee_ssn: current_employee.ssn).present?
            @requests = []
            status_id = Status.where(name: "Pending Final Approval").take.id
            
            @authforms = AuthorizationForm.where(status_id: status_id)
            render 'authform_index_payment'

        else
            status_id = Status.where(name: "Pending").take.id
            @requests = Request.where(department_id: current_employee.department_id, 
                                      status_id: status_id)
        end
        
    end
    
    def authform_show
        @trip = Trip.find(params[:id])
        @wishes = @trip.authorization_form.wishes
        @requests = @trip.requests
    end
    
    def authform_history
    
    end
    
    def authform_update
        if PaymentManager.where(employee_ssn: current_employee.ssn).present?
            authorization_form = AuthorizationForm.find(params[:id])
            trip = authorization_form.trip
            status_id = params[:status_id]
            authorization_form.update_attribute(:status_id, status_id)
    
            redirect_to manage_auth_path(trip), :notice => "Updated Successfully!"
        else
            req = Request.find(params[:id])
            @trip = req.trip
            @authorization_form = @trip.authorization_form
            status_id = params[:status_id]
            req.update_attribute(:status_id, status_id)
            update_authform_status
    
            redirect_to manage_auth_path(@trip), :notice => "Updated Successfully!"
        end
    end
    
#**********Manage Reimburse Form**********#
    def reimform_index
    end
    
    
    def reimform_show
    end
    
    def reimform_history
    
    end
    
    def reimform_update
    end
    
    private 
        #update authorization form status to approve or partial approved if conditions meet
        def update_authform_status
            approved_id = Status.where(name: "Approved").take.id
            p_approved_id = Status.where(name: "Partial Approved").take.id
            pending_id = Status.where(name: "Pending").take.id
            denied_id = Status.where(name: "Denied").take.id
            pfa_id = Status.where(name: "Pending Final Approval").take.id
            
            ##true means record exists
            pb = !(Request.where(trip_id: @trip.id, status_id: pending_id).empty?) #pb = pending_boolean
            ab = !(Request.where(trip_id: @trip.id, status_id: approved_id).empty?) #ab = approved_boolean
            db = !(Request.where(trip_id: @trip.id, status_id: denied_id).empty?) #db = denied_boolean
        
            if db == false
                #check partial approved condition
                if pb && ab && (db == false)
                    if @authorization_form.id != p_approved_id #update only if the current status is not partial approved already
                        @authorization_form.update_attribute(:status_id, p_approved_id)
                    end
                end
                
                #check approved condition, if all approved, the status will change to Pending Final Approval
                if (pb == false) && ab && (db == false)
                    @authorization_form.update_attribute(:status_id, pfa_id)
                end
            else
                @authorization_form.update_attribute(:status_id, denied_id)
            end
        end
end

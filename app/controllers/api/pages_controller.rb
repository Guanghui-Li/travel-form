module Api
    class PagesController < ApplicationController  

        def getdestination
            trips = Trip.where("employee_id = " + (current_employee.id.to_s if current_employee))
            
            destinations = []
            
            trips.each do |trip|
              destinations.push(trip.destination)
            end
            
            render json: {data: destinations}
        end
        
        def getExpensiveDest
            trips = Trip.where("employee_id = " + (current_employee.id.to_s if current_employee))
            
            expensiveDest = []
            
            trips.each do |trip|
                expensiveDest.push(trip.destination)
            end
            
            render json: {data: expensiveDest}
        end
        
        def allstatus
             statuses = ["Pending", "Pending Final Approval", "Partial Approved", "Approved", "Denied"]
            num = [
                    AuthorizationForm.where(:employee_id => current_employee.id, :status_id => Status.where(name: "Pending").take.id).to_a.count,
                    AuthorizationForm.where(:employee_id => current_employee.id, :status_id => Status.where(name: "Pending Final Approval").take.id).to_a.count,
                    AuthorizationForm.where(:employee_id => current_employee.id, :status_id => Status.where(name: "Partial Approved").take.id).to_a.count,
                    AuthorizationForm.where(:employee_id => current_employee.id, :status_id => Status.where(name: "Approved").take.id).to_a.count,
                    AuthorizationForm.where(:employee_id => current_employee.id, :status_id => Status.where(name: "Denied").take.id).to_a.count
                  ]
            render json: {statuses: statuses, num: num}
        end

        def deptApproveRate
            depts = ["Computer Science", "English", "Math"]

            num = [
                AuthorizationForm.where(:status_id => Status.where(name: "Pending Final Approval").take.id).to_a.count,
                AuthorizationForm.where(:status_id => Status.where(name: "Pending Final Approval").take.id).to_a.count,
                AuthorizationForm.where(:status_id => Status.where(name: "Pending Final Approval").take.id).to_a.count
                ]

            render json: {depts: depts, num: num}
        end

        def getEmpName
            empName = Employee.find(current_employee.id).fname
            
            render json: {empName: empName}
        end
    end
end

class Department < ApplicationRecord
    has_many :employees
    has_many :requests, :dependent => :destroy
    has_many :receipts_request, :dependent => :destroy
    
    validates :name, :manager_ssn, :total_budget, :budget_hold, presence: true
    validates :name, uniqueness: true
end

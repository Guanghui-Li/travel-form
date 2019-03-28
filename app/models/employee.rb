class Employee < ApplicationRecord
    belongs_to :department
    
    has_many :trips
    has_many :authorization_forms
    has_many :reimbursement_forms
end

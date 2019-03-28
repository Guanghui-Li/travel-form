class Employee < ApplicationRecord
    belongs_to :department
    
    has_many :trips
    has_many :authorization_forms
    
    validates :department_id, :email, :fname, :lname, :ssn, :bdate, presence: true
    validates :email, :ssn, uniqueness: true
    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}

    
end

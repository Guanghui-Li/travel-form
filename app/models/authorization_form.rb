class AuthorizationForm < ApplicationRecord
    belongs_to :employee
    belongs_to :trip
    belongs_to :status
    has_many :notification

    has_many :wishes, :dependent => :destroy
    
    
    validates :status_id, :employee_id, presence: true
    accepts_nested_attributes_for :wishes
end

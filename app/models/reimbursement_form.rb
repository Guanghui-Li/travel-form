class ReimbursementForm < ApplicationRecord
    belongs_to :employee
    belongs_to :trip
    belongs_to :status
    
    has_many :receipts, :dependent => :destroy
    
    validates :status_id, :employee_id, :trip_id, presence: true
    
    accepts_nested_attributes_for :receipts, :reject_if => :all_blank, :allow_destroy => true

end

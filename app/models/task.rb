class Task < ApplicationRecord
    validates :content, presence: true , length: { maximum: 255 }
    validates :status, presence: true , length: { maximum: 10 }
    
    #　1対多　user << task
    belongs_to :user
    validates :content, presence: true, length: { maximum: 255 }
end

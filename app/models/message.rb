class Message < ApplicationRecord
    belongs_to :speaker, class_name: "User"
    belongs_to :target, class_name: "User"
    validates :message, presence: true,length: {maximum: 140}
    
end

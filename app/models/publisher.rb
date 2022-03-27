class Publisher < ApplicationRecord
    #associations
    has_many:books
    has_many:authors,through: :books
    has_many:book_types,through: :books
    
    #validates
    validates_associated :books
    validates :name, presence: true 
    validates :name, length: { maximum: 100 }
end

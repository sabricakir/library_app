class Publisher < ApplicationRecord
    #associations
    has_many:books, dependent: :destroy
    has_many:authors,through: :books
    has_many:book_types,through: :books

    #callbacks
    before_save :normalize_publisher_name
    
    
    #validates
    validates_associated :books
    validates :name, presence: true 
    validates :name, length: { maximum: 100 }

    #methods
    private def normalize_publisher_name
        self.name = name.upcase.strip
    end    
end

class BookType < ApplicationRecord
    #associations
    has_many:books, dependent: :destroy
    has_many:authors,through: :books
    has_many:publishers,through: :books

    #callbacks
    before_save :normalize_book_type_name  

    #validates
    validates_associated :books
    validates :typeName, presence: true 
    validates :typeName, length: { maximum: 50 }

    #methods
    private def normalize_book_type_name
        self.typeName = typeName.upcase.strip
    end    
end

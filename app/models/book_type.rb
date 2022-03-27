class BookType < ApplicationRecord
    #associations
    has_many:books
    has_many:authors,through: :books
    has_many:publishers,through: :books

    #validates
    validates_associated :books
    validates :typeName, presence: true 
    validates :typeName, length: { maximum: 50 }
end

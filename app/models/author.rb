class Author < ApplicationRecord
    #associations
    has_many:books
    has_many:book_types,through: :books
    has_many:publishers,through: :books

    #validates
    validates_associated :books
    validates :name, presence: true 
    validates :name, length: { maximum: 75 }
    validates :age, presence: true
    validates :age, inclusion:{in: 1..150, message: "isn't probably a valid age"}
    validates :birthPlace, presence: true
    validates :birthPlace, length: { in: 3..50 }
end

class Author < ApplicationRecord
    #associations
    has_many:books, dependent: :destroy
    has_many:book_types,through: :books
    has_many:publishers,through: :books

    #callbacks
    before_save :normalize_author_attributes

    #validates
    validates_associated :books
    validates :name, presence: true 
    validates :name, length: { maximum: 75 }
    validates :age, presence: true
    validates :age, inclusion:{in: 1..150, message: "isn't probably a valid age"}
    validates :birthPlace, presence: true
    validates :birthPlace, length: { in: 3..50 }

    #methods
    private def normalize_author_attributes
        fullName=""
        namePieces=name.split(" ")
        fullName+=namePieces[0].downcase.capitalize+" "  
        namePieces[1..-1].each{|surname| fullName+=surname.upcase+" "}
        self.name = fullName.strip
        self.birthPlace = birthPlace.titleize.strip
    end
end

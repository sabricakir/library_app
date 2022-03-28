class Book < ApplicationRecord

    #associations
    belongs_to :author
    belongs_to :publisher
    belongs_to :book_type
    
    #callbacks
    before_save :normalize_book_name

    #validates
    validates :name, presence: true 
    validates :name, length: { maximum: 200 }
    validates :page, presence: true
    validates :page, length: { in: 1..5 }

    #methods
    private def normalize_book_name
        self.name = name.upcase.strip
    end
end

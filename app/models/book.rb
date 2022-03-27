class Book < ApplicationRecord
    #associations
    belongs_to :author
    belongs_to :publisher
    belongs_to :book_type

    #validates
    validates :name, presence: true 
    validates :name, length: { maximum: 200 }
    validates :page, presence: true
    validates :page, length: { in: 1..5 }
end

class Book < ApplicationRecord
    belongs_to :authors
    belongs_to :publishers
    belongs_to :book_types
end

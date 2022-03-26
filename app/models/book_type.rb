class BookType < ApplicationRecord
    has_many:books
    has_many:authors,through: :books
    has_many:publishers,through: :books
end

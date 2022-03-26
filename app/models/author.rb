class Author < ApplicationRecord
    has_many:books
    has_many:book_types,through: :books
    has_many:publishers,through: :books
end

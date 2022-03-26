class AddBookTypeReferenceToBook < ActiveRecord::Migration[7.0]
  def change
    add_reference :books, :book_type, foreign_key: true
  end
end

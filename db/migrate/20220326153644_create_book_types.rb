class CreateBookTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :book_types do |t|
      t.text :name

      t.timestamps
    end
  end
end

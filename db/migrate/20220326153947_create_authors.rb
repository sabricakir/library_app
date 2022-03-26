class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.text :name
      t.integer :age
      t.text :birthPlace

      t.timestamps
    end
  end
end

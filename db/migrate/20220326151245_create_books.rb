class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.text :name
      t.integer :page

      t.timestamps
    end
  end
end

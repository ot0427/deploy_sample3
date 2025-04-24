# db/migrate/005_create_progresses.rb
class CreateProgresses < ActiveRecord::Migration[8.0]
  def change
    create_table :progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :goal, null: false, foreign_key: true
      t.integer :value
      t.text :notes

      t.timestamps
    end
  end
end

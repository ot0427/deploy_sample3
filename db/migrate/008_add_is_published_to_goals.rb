class AddIsPublishedToGoals < ActiveRecord::Migration[8.0]
  def change
    add_column :goals, :is_published, :boolean, default: true, null: false
  end
end

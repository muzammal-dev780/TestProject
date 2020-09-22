# frozen_string_literal: true

# CreatePlans
class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :fee
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

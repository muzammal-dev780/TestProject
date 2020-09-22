# frozen_string_literal: true

# CreateUsages
class CreateUsages < ActiveRecord::Migration[5.2]
  def change
    create_table :usages do |t|
      t.references :user, foreign_key: true
      t.references :plan, foreign_key: true
      t.references :subscription, foreign_key: true
      t.integer :units_count

      t.timestamps
    end
  end
end

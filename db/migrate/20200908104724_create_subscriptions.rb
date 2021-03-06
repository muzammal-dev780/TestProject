# frozen_string_literal: true

# CreateSubscriptions
class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true
      t.references :plan, foreign_key: true
      t.integer :bill_day

      t.timestamps
    end
  end
end

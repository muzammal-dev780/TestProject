# frozen_string_literal: true

# AddIndexToUsages
class AddIndexToUsages < ActiveRecord::Migration[5.2]
  def change
    add_index :usages, %i[subscription_id feature_id], unique: true
  end
end

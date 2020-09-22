# frozen_string_literal: true

# AddTimestampsToFeatures
class AddTimestampsToFeatures < ActiveRecord::Migration[5.2]
  def change
    add_column :features, :created_at, :datetime, default: DateTime.now
    add_column :features, :updated_at, :datetime, default: DateTime.now
  end
end

# frozen_string_literal: true

# RemoveFeatureIdFromSubscriptions
class RemoveFeatureIdFromSubscriptions < ActiveRecord::Migration[5.2]
  def change
    remove_column :subscriptions, :feature_id
  end
end

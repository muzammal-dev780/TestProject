# frozen_string_literal: true

class AddFeatureIdToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_reference :subscriptions, :feature, foreign_key: true
  end
end

# frozen_string_literal: true

# Plan model
class Plan < ApplicationRecord
  has_many :features, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :fee, presence: true
end

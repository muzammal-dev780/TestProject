# frozen_string_literal: true

class Plan < ApplicationRecord
  has_many :features
  has_many :subcriptions

  validates :name, presence: true
  validates :fee, presence: true
end

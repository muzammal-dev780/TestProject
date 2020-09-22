# frozen_string_literal: true

# Feature model
class Feature < ApplicationRecord
  belongs_to :plan
  has_many :usages
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  validates :unit_price, presence: true
  validates :max_unit_limit, presence: true
end

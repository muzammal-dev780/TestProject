# frozen_string_literal: true

class Feature < ApplicationRecord
  belongs_to :plan
  validates_uniqueness_of :code
end

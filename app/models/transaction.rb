# frozen_string_literal: true

# Transaction model
class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :subscription
end

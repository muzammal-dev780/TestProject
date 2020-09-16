class Usage < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  belongs_to :subscription
  belongs_to :feature
end

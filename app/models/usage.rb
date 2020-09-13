class Usage < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  belongs_to :feature
  belongs_to :subscription
end

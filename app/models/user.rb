# frozen_string_literal: true

class User < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
	has_many :subscriptions
	has_many :transactions
	enum role: %i[user admin]
	after_initialize :set_default_role, if: :new_record?
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :validatable
	# User Avatar Validation
	validates_integrity_of  :avatar
	validates_processing_of :avatar
 
	private
		def avatar_size_validation
		  errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
		end
	
		def set_default_role
			self.role ||= :user
		end
end

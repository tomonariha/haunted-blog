# frozen_string_literal: true

class Blog < ApplicationRecord
  include ActiveModel::Validations
  validates_with BlogValidator
  belongs_to :user
  has_many :likings, dependent: :destroy
  has_many :liking_users, class_name: 'User', source: :user, through: :likings

  validates :title, :content, presence: true

  scope :published, -> { where('secret = FALSE') }

  scope :search, lambda { |term|
    where('title LIKE ? OR content LIKE ?', "%#{term}%", "%#{term}%")
  }

  scope :default_order, -> { order(id: :desc) }

  scope :owned, -> (current_user){ where('user_id = ?', current_user) }

  def owned_by?(target_user)
    user == target_user
  end
end

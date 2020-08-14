# frozen_string_literal: true

# class Project
class Project < ApplicationRecord
  # Relations
  has_many :items, dependent: :destroy

  # Validations
  validates :title, presence: true, uniqueness: true

  # Soft Delete
  acts_as_paranoid
end

# frozen_string_literal: true

# class Item
class Item < ApplicationRecord
  # Relations
  belongs_to :project

  # Validations
  validates :action, presence: true, uniqueness: { scope: :project, message: 'should be unique within a project' }

  # Scopes
  scope :complete, -> { where(done: true) }

  # Soft Delete
  acts_as_paranoid
end

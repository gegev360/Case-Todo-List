# app/models/item.rb
class Item < ApplicationRecord
  belongs_to :todo_list
  
  validates :description, presence: true
  
  # Define by default an item is created as not completed
  attribute :completed, :boolean, default: false
  
  # Scopes to filter items
  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
end
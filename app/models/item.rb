class Item < ApplicationRecord
  belongs_to :todo_list
  
  validates :description, presence: true
  
  # Define que por padrão um item é criado como não concluído
  attribute :completed, :boolean, default: false
end

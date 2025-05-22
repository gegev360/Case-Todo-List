class AddUserToTodoLists < ActiveRecord::Migration[8.0]
  def change
    add_reference :todo_lists, :user, null: true, foreign_key: true
    
    # Depois de migrar os dados existentes, podemos adicionar a restrição
    # execute("UPDATE todo_lists SET user_id = (SELECT id FROM users LIMIT 1)")
    # change_column_null :todo_lists, :user_id, false
  end
end

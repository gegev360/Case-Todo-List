# test/models/todo_list_test.rb
require "test_helper"

class TodoListTest < ActiveSupport::TestCase
  test "should not save todo list without title" do
    todo_list = TodoList.new
    assert_not todo_list.save, "Salvou a lista sem título"
  end

  test "should save with valid attributes" do
    todo_list = TodoList.new(title: "Compras")
    assert todo_list.save, "Não salvou a lista com título válido"
  end

  # test "should destroy associated items when deleted" do
  #   todo_list = TodoList.create(title: "Teste")
  #   item = todo_list.items.create(description: "Item teste")
    
  #   assert_difference('Item.count', -1) do
  #     todo_list.destroy
  #   end
  # end
end
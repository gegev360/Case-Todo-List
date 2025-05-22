# test/models/item_test.rb
require "test_helper"

class ItemTest < ActiveSupport::TestCase
  # test "should not save item without description" do
  #   item = Item.new(todo_list: todo_lists(:one))
  #   assert_not item.save, "Salvou o item sem descrição"
  # end
  
  # test "should save with valid attributes" do
  #   item = Item.new(description: "Teste", todo_list: todo_lists(:one))
  #   assert item.save, "Não salvou o item com atributos válidos"
  # end
  
  # test "should be incomplete by default" do
  #   item = Item.new(description: "Teste", todo_list: todo_lists(:one))
  #   assert_equal false, item.completed, "Item não começa como incompleto"
  # end
  
  # test "should belong to a todo list" do
  #   item = items(:one)
  #   assert_not_nil item.todo_list, "Item não está associado a uma lista"
  # end

  # test "should filter completed items" do
  #   assert_equal 1, Item.completed.count
  #   assert_includes Item.completed, items(:two)
  # end

  # test "should filter pending items" do
  #   assert_equal 1, Item.pending.count
  #   assert_includes Item.pending, items(:one)
  # end 
end
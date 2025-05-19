require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todo_list = todo_lists(:one)
    @item = items(:one)
  end

  test "should create item" do
    assert_difference("Item.count") do
      post todo_list_items_url(@todo_list), params: { item: { description: "Novo item" } }
    end
    assert_redirected_to todo_list_url(@todo_list)
  end

  test "should destroy item" do
    assert_difference("Item.count", -1) do
      delete todo_list_item_url(@todo_list, @item)
    end
    assert_redirected_to todo_list_url(@todo_list)
  end

  test "should update item" do
    patch todo_list_item_url(@todo_list, @item), params: { item: { description: "Atualizado" } }
    assert_redirected_to todo_list_url(@todo_list)
  end

  test "should toggle complete item" do
    patch toggle_complete_todo_list_item_url(@todo_list, @item)
    assert_redirected_to todo_list_url(@todo_list)
  end
end
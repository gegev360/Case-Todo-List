require "test_helper"

class TodoListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get todo_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_todo_list_url
    assert_response :success
  end

  test "should create todo_list" do
    assert_difference("TodoList.count") do
      post todo_lists_url, params: { todo_list: { title: "Nova Lista", description: "Descrição" } }
    end
    assert_redirected_to todo_list_url(TodoList.last)
  end

  test "should get edit" do
    todo_list = todo_lists(:one)
    get edit_todo_list_url(todo_list)
    assert_response :success
  end

  test "should update todo_list" do
    todo_list = todo_lists(:one)
    patch todo_list_url(todo_list), params: { todo_list: { title: "Atualizado" } }
    assert_redirected_to todo_list_url(todo_list)
  end

  test "should destroy todo_list" do
    todo_list = todo_lists(:one)
    assert_difference("TodoList.count", -1) do
      delete todo_list_url(todo_list)
    end
    assert_redirected_to todo_lists_url
  end

  test "should show todo_list" do
    todo_list = todo_lists(:one)
    get todo_list_url(todo_list)
    assert_response :success
  end
end
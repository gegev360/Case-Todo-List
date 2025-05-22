class TodoListsController < ApplicationController
  before_action :set_todo_list, only: [ :show, :edit, :update, :destroy ]

  def index
    @todo_lists = current_user.todo_lists
  end

  def show
    authorize_user_list
  end

  def new
    @todo_list = current_user.todo_lists.build
  end

  def edit
    authorize_user_list
  end

  def create
    @todo_list = current_user.todo_lists.build(todo_list_params)

    if @todo_list.save
      redirect_to @todo_list, notice: "Lista de tarefas criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize_user_list
    
    if @todo_list.update(todo_list_params)
      redirect_to @todo_list, notice: "Lista de tarefas atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize_user_list
    
    @todo_list.destroy
    redirect_to todo_lists_url, notice: "Lista de tarefas excluída com sucesso."
  end

  private
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    def todo_list_params
      params.require(:todo_list).permit(:title, :description)
    end
    
    def authorize_user_list
      unless @todo_list.user_id == current_user.id
        redirect_to todo_lists_path, alert: "Você não tem permissão para acessar esta lista."
      end
    end
end

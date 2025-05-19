class ItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_item, only: [:update, :destroy, :toggle_complete]

  def create
    @item = @todo_list.items.new(item_params)
    
    if @item.save
      redirect_to @todo_list, notice: 'Item criado com sucesso.'
    else
      redirect_to @todo_list, alert: 'Erro ao criar o item.'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @todo_list, notice: 'Item atualizado com sucesso.'
    else
      redirect_to @todo_list, alert: 'Erro ao atualizar o item.'
    end
  end

  def destroy
    @item.destroy
    redirect_to @todo_list, notice: 'Item excluído com sucesso.'
  end
  
  def toggle_complete
    @item.update(completed: !@item.completed)
    redirect_to @todo_list
  end

  private
    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end
    
    def set_item
      @item = @todo_list.items.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:description, :completed)
    end
end

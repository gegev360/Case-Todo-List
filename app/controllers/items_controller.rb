class ItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_item, only: [ :update, :destroy, :toggle_complete ]

  def create
    @item = @todo_list.items.new(item_params)

    if @item.save
      respond_to do |format|
        format.html { redirect_to @todo_list, notice: "Item criado com sucesso." }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append("items", partial: "todo_lists/item", locals: { item: @item, todo_list: @todo_list }),
            turbo_stream.replace("new_item_form", partial: "todo_lists/form", locals: { todo_list: @todo_list }),
            turbo_stream.replace("items-counter", partial: "todo_lists/items_counter", locals: { todo_list: @todo_list })
          ]
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to @todo_list, alert: "Erro ao criar o item." }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_item_form", partial: "todo_lists/form", locals: { todo_list: @todo_list, item: @item }) }
      end
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @todo_list, notice: "Item atualizado com sucesso."
    else
      redirect_to @todo_list, alert: "Erro ao atualizar o item."
    end
  end

  def destroy
    @item.destroy
    
    respond_to do |format|
      format.html { redirect_to @todo_list, notice: "Item excluído com sucesso." }
      format.turbo_stream { 
        render turbo_stream: [
          turbo_stream.remove(@item),
          turbo_stream.replace("items-counter", partial: "todo_lists/items_counter", locals: { todo_list: @todo_list })
        ]
      }
    end
  end

  def toggle_complete
    @item.update(completed: !@item.completed)
    
    respond_to do |format|
      format.html { redirect_to @todo_list }
      format.turbo_stream { 
        render turbo_stream: [
          turbo_stream.replace(@item, partial: "todo_lists/item", locals: { item: @item, todo_list: @todo_list }),
          turbo_stream.replace("items-counter", partial: "todo_lists/items_counter", locals: { todo_list: @todo_list })
        ]
      }
    end
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

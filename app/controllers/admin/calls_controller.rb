class Admin::CallsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  
  def index
    calls = Call.where(completed: false)
    
    @calls_new = calls.select { |call| !call.saved }
    @calls_saved = calls.select { |call| call.saved }
  end

  def edit
    @call = Call.find(params[:id])
  end

  def update
    @call = Call.find(params[:id])
    path = @call.completed ? admin_calls_arhive_path : admin_calls_path
    if @call.update_columns(notes: params[:call][:notes])
      redirect_to "#{path}#message=Заявка обновлена"
    else
      render :edit
    end
  end

  def complete
    @call = Call.find(params[:id])
    if @call.update_columns(completed: true, saved: false)
      redirect_to "#{admin_calls_path}#message=Заявка обработана"
    else
      redirect_to "#{admin_calls_path}#message=Произошла неведомая херня"
    end
  end

  def save
    @call = Call.find(params[:id])
    path = @call.completed ? admin_calls_arhive_path : admin_calls_path
    if @call.update_columns(saved: @call.saved ? false : true, completed: false)
      redirect_to "#{path}#message=Заявка сохранена"
    else
      redirect_to "#{path}#message=Произошла неведомая херня"
    end
  end

  def arhive
    @calls = Call.where(completed: true)
  end

  def destroy
    @call = Call.find(params[:id])
    path = @call.completed ? admin_calls_arhive_path : admin_calls_path
    if @call.destroy
      redirect_to "#{path}?message=Заявка удалена"
    else
      render :index
    end
  end
end

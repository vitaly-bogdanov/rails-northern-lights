class CallsController < ApplicationController

  # на данный метод ajax'ом приходит имя и телефон из круглой формы
  def create
    @call = Call.new(name: params[:name], telephone: params[:telephone], confirm: params[:confirm], timezone: params[:timezone])
    if @call.save 
      render json: {controller: 'call#create'}, status: :created 
    else
      render :json => {controller: 'call#create', errors: @call.errors}, status: 422 #:unprocessable_entity
    end
  end

end

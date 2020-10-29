class Admin::InstalinksController < ApplicationController
  include ProtectRoutesConcern
  layout 'admin'
  before_action :signed_in?
  
  def edit
    @instalinks = Instalink.info
  end

  def update
    @instalinks = Instalink.info
    @instalinks.update_info(instalinks_params)
    redirect_to "#{admin_instalink_path}#message=\"Перечень ссылок обновлен\""
  end

  private

  def instalinks_params
    params.require(:instalink).permit(:whatsapp, :telegram, :facebook)
  end
end

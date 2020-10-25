class Admin::InstalinksController < ApplicationController
  layout 'admin'
  include ProtectRoutesConcern
  before_action :signed_in?
  
  def edit
    @instalinks = Instalink.info
  end

  def update
    @instalinks = Instalink.info
    @instalinks.update_info(instalinks_params)
    flash['links_update'] = 'Перечень ссылок обновлен'
    redirect_to admin_instalink_path
  end

  private

  def instalinks_params
    params.require(:instalink).permit(:whatsapp, :telegram, :facebook)
  end
end

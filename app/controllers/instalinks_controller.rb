class InstalinksController < ApplicationController
  before_action :set_contacts

  # GET /instalinks
  def index
    instalinks = Instalink.info
    @whatsapp = instalinks.whatsapp
    @telegram = instalinks.telegram
    @facebook = instalinks.facebook
    render layout: false
  end
end

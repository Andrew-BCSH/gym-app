# app/controllers/pages/membership_payments_controller.rb
class Pages::MembershipsController < ApplicationController
  def index
    @options = Option.all
  end
end

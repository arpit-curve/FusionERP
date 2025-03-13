# frozen_string_literal: true

class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @organization = current_user.organization
    presenter = DashboardPresenter.new(@organization)

    render json: presenter.data
  end
end

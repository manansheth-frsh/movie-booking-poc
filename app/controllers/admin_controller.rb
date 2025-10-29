class AdminController < ApplicationController
  include AccessConcern
  before_action :require_admin, only: [:index, :new, :create, :edit, :update, :destroy]
  def index
  end
end

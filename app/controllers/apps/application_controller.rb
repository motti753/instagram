class Apps::ApplicationController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
end
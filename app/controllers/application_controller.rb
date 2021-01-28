class ApplicationController < ActionController::Base
  helper_method :is_admin!

  helper_method :is_authorized!

  private
  def is_authorized!
    if helpers.is_user_admin!
    else
      redirect_to root_path
    end
  end

  def is_admin!
    helpers.is_user_admin!
  end
end

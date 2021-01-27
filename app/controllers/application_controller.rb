class ApplicationController < ActionController::Base
  helper_method :is_admin!


  private

  def is_admin!
    if helpers.is_user_admin!
    else
      redirect_to root_path
    end
  end
end

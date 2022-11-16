class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
    skip_before_action :verify_authenticity_token
    # crrlll
    def current_user
        @current_user = User.find_by(session_token: session[:session_token])
        return nil if @current_user.nil?
        @current_user
    end
    def require_logged_in
        redirect_to new_session_url unless logged_in?
    end
    def require_logged_out
        redirect_to users_url unless logged_in?
    end
    def logged_in?
        !!current_user
    end
    def login!(user)
        session[:session_token] = user.reset_session_token!
    end
    def logout
        current_user.reset_session_token!
        session[:session_token] = nil
        @current_user = nil
        redirect_to users_url
    end
end

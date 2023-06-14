class SessionsController<ApplicationController
    def new
        @user=User.new
        render :new
    end
    def create 
        user_email=params[:user][:email]
        user_password=params[:user][:password]
        @user=User.find_by_credentials(user_email,user_password)
        if @user 
            login(@user)
            redirect_to user_url(@user)
        else
            flash[:errors]=@user.errors.full_messages
            render :new
    end
end
end
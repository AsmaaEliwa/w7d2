class UsersController < ApplicationController
    def index
        @users=User.all
        render :index
    end
     def show
      @user =User.find(params[:id])
      render json: @user
     end
    def new
        @user=User.new
        render :new
    end

    def create
       @user=User.new(user_params)
       if @user.save
        login(@user)
        redirect_to users_url(@user.id)

       else
        flash.now[:errors]=@user.errors.full_messages 
        render :new

    end
end

    def user_params
        params.require(:user).permit(:email,:password)
    end
end

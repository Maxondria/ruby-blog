class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params.fetch(:email))

    if @user&.is_password?(user_params.fetch(:password))
      session[:user_id] = @user.id
      redirect_to posts_path, notice: "Logged in as #{@user.email}"
    else
      flash.now[:alert] = 'Invalid email or password!'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_path, notice: 'Successfully logged out!'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

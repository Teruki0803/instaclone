class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to users_path
      flash[:alert] = '不正なアクセスです'
    end
 end
 
 def update
   @user = User.find(params[:id])
   if @user.update(user_params)
    redirect_to user_path(@user)
    flash[:notice] =  "ユーザー情報を更新しました。"
   else
     render :edit
   end  
 end
 
 def destroy
   User.find(params[:id]).destroy
   flash[:success] = "削除に成功しました"
   redirect_to users_path
 end

private
  def user_params 
    params.require(:user).permit(:name,:email, :profile, :profile_image)
  end

end
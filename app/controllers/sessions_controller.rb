class SessionsController < ApplicationController
  def new
  end
  
  def create
    user=User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success]="ログイン成功！"
      redirect_back_or user
    else
      flash.now[:danger]="Invalid email/password combination"
      # renderの場合、リクエストを送信しないのでflashが２回表示されてしまう
      # .nowを使う事で次のリクエスト時に消えるように出来る
      render "new"
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
end

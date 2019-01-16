class MicropostsController < ApplicationController
  before_action :logged_in_user, only:[:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @microposts=current_user.microposts.build(microposts_params)
    if @microposts.save
      flash[:success]="投稿しました！"
      redirect_to root_path
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_path
  end
  
  private
  
  def microposts_params
    params.require(:micropost).permit(:content, :picture)
  end
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

end

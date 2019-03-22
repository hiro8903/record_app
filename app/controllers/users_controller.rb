class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new # 新規作成されたUserオブジェクトをインスタンス変数に代入します
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザーの新規作成に成功しました。"
      # Bootstrapではこのようなflashのクラス用に4つのスタイルを持っています。
      # 1. sucsuccess（緑色：保存の成功など） 
      # 2. info（青色：インフォメーション）
      # 3. warning（黄色：警告メッセージ）
      # 4. danger（赤色：エラーメッセージ）
      redirect_to @user #ブラウザ表示をリダイレクトして、登録されたユーザーの情報表示画面に遷移します。
    else
      render 'new'
    end
  end

  def edit
    # @user = User.find(params[:id]) correct_userメソッドにて、同様のインスタンス変数への代入文が記述されているから不要になった。
  end
  
  def update
    # @user = User.find(params[:id]) correct_userメソッドにて、同様のインスタンス変数への代入文が記述されているから不要になった。
    if @user.update_attributes(user_params)
      # 更新に成功した場合の処理
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "削除しました。"
    redirect_to users_url
  end
  
  
  def index
    @users = User.paginate(page: params[:page]) # paginateメソッドの働きにより、ユーザーのページネーションが行えるようになりました。
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    #Strong Parametersというテクニックを使用することが推奨されています。
    #Strong Parametersを用いることで、必須となるパラメータと許可されたパラメータを指定することができます。
    #今回の場合、paramsハッシュでは:user属性を必須とし、名前（:name）、メールアドレス（:email）、
    #パスワード（:password）、パスワードの確認（:password_confirmation）をそれぞれ許可し、それ以外を許可しないようにします。
    
    
    # beforeアクション

    # ログイン済みユーザーか確認
    def logged_in_user
      unless logged_in?
        
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end
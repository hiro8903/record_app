class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new # 新規作成されたUserオブジェクトをインスタンス変数に代入します
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
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

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    #Strong Parametersというテクニックを使用することが推奨されています。
    #Strong Parametersを用いることで、必須となるパラメータと許可されたパラメータを指定することができます。
    #今回の場合、paramsハッシュでは:user属性を必須とし、名前（:name）、メールアドレス（:email）、
    #パスワード（:password）、パスワードの確認（:password_confirmation）をそれぞれ許可し、それ以外を許可しないようにします。
end
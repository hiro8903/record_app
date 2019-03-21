class User < ApplicationRecord
  # ActiveRecordでは検証（Validation）という機能を通して、制約を与えることができるようになっています。
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  # 存在性（presence）の検証
  # 長さ（length）の検証
  # フォーマットの（format）検証    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i は完全ではないが現実的に実践できる正規表現
  # 一意性（unique）の検証    一意とは、他に同じデータがない。という意味  uniqueness: true　ではsample@tutorial.comやSAMPLE@TUTORIAL.COMの扱いが同じになってしまう。
  # before_save { self.email = email.downcase }  オブジェクトが保存される前にメソッドを呼び出したいので、before_saveというコールバックメソッドを使用。あらゆるデータベースで、大文字小文字を区別せず、小文字として登録される。
  # has_secure_password has_secure_passwordを使ってパスワードをハッシュ化（入力されたデータを元に戻せないデータにする処理）するためには、bcryptというgemが必要。
end

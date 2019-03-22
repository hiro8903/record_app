class AddAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :admin, :boolean,  default: false
  end
  #念の為、デフォルトでは管理者（admin属性がtrue）にはなれないことを明示している。
end

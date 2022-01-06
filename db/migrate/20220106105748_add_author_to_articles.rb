class AddAuthorToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :author, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end

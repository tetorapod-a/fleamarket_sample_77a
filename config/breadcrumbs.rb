# ルート
crumb :root do
  link "トップページ", root_path
end

crumb :sign_in do
  link "ログインページ", users_path
end 

# マイページ
crumb :mypage do
  link "マイページ", user_path
end  

# 会員情報編集画面
crumb :users_edit do
  link "会員情報編集", users_update_path
  # parent :mypage
end  

# 送付先情報編集画面
crumb :address_user do
  link "送付先情報編集", addresses_update_path
  # parent :mypage
end  



# crumb :mypage do
#   link "登録完了", users_registrations_create_addres_path
# end  

# # crumb :projects do
# #   link "Projects", projects_path
# # end

# # crumb :project do |project|
# #   link project.name, project_path(project)
# #   parent :projects
# # end

# # crumb :project_issues do |project|
# #   link "Issues", project_issues_path(project)
# #   parent :project, project
# # end

# # crumb :issue do |issue|
# #   link issue.title, issue_path(issue)
# #   parent :project_issues, issue.project
# # end

# # If you want to split your breadcrumbs configuration over multiple files, you
# # can create a folder named `config/breadcrumbs` and put your configuration
# # files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# # folder are loaded and reloaded automatically when you change them, just like
# # this file (`config/breadcrumbs.rb`).
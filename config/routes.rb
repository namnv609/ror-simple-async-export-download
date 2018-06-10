Rails.application.routes.draw do
  root to: "users#index"
  get "/export" => "users#export"
  get "/export_status" => "users#export_status"
  get "/export_download" => "users#export_download"
end

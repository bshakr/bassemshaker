Rails.application.routes.draw do
  root 'pages#root'
  get '/about' => 'pages#about'
end

Zhaosheng::Application.routes.draw do
  resources :snips

  match '/moshi-:moshi-leibie-:leibie-duixiang-:duixiang'=>'majors#index'
  match '/leibie-:leibie-duixiang-:duixiang'=>'majors#index'
  match '/moshi-:moshi-leibie-:leibie'=>'majors#index'
  match '/moshi-:moshi-duixiang-:duixiang'=>'majors#index'
  match '/moshi-:moshi'=>'majors#index'
  match '/leibie-:leibie'=>'majors#index'
  match '/duixiang-:duixiang'=>'majors#index'
  match '/xuexiao-:xuexiao'=>'majors#index',:as=>"xuexiao"
  resources :majors,:path=>'zhuanye'

  resources :schools,:path=>'xuexiao'

  #authenticated :user do
    #root :to => 'home#index'
  #end
  root :to => "majors#index"
  devise_for :users
  resources :users
end

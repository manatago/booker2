Rails.application.routes.draw do

  get 'search'=>"searches#search",as: :search
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  devise_for :users

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]
  resources :users, only: [:index,:show,:edit,:update]
  resources :favorites, only: [:create,:destroy]
  resources :book_comments, only: [:create,:destroy]
  resources :relationships, only: [:create,:destroy]
  resources :groups, only: [:new,:create,:index,:edit,:update,:show]
  
  get 'users/:id/follows' => "users#index", as: :follow_list
  get 'users/:id/followers'=>'users#index', as: :follower_list
  
  
  
  get 'messages/:speaker/:target'=>"messages#index",as: :messages
  post 'messages/:speaker/:target'=>"messages#create"
  
  post 'users/:id/post_count'=>"users#post_count",as: :post_count
  post 'join/group/:id'=>"groups#join",as: :join_group
  delete 'out/group/:id'=>"groups#out_group",as: :out_group
  
  get 'notice_an_event/:id'=>"groups#notice_an_event",as: :notice_an_event
  post 'notice_an_event/:id'=>"groups#send_email"
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

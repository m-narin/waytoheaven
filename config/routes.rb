Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#Tweetの投稿に関するページ
  #投稿ページ表示
  get 'tweets/zangenew' => 'tweets#zangenew'
  post 'tweets' => 'tweets#create'

  get 'tweets/zenkounew' => 'tweets#zenkounew'
  post 'tweets' => 'tweets#create'

  #懺悔投稿一覧
  get 'zangetweets' => 'tweets#zangeindex'
  get 'zenkoutweets' => 'tweets#zenkouindex'

  # 説明ページ
  get 'about' => 'tweets#about'
  get 'hells' => 'tweets#hells'
  get 'links' => 'tweets#links'
  get 'heaven' => 'tweets#heaven'



  resources :tweets do
    resources :comments, only: [:create, :destroy]
  end

  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end

  root 'tweets#zenkouindex'

end

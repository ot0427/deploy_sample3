Rails.application.routes.draw do
  get "comments/create"
  get "comments/edit"
  get "comments/update"
  get "comments/destroy"
  # ユーザー認証用（Devise）
  devise_for :users

  # Goal（目標）と、その配下に Progress（進捗）をネスト
  resources :goals do
    resources :progresses, only: [ :create ]
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  # 投稿機能（もし Posts を使うならそのまま）
  resources :posts

  # ヘルスチェック用
  get "up" => "rails/health#show", as: :rails_health_check

  # トップページ
  root "goals#index"
end

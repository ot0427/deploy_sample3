Rails.application.routes.draw do
  get "home/index"
  get "pages/terms"
  get "comments/create"
  get "comments/edit"
  get "comments/update"
  get "comments/destroy"

  # ユーザー認証（Devise）
  devise_for :users

  # ログイン状態でトップページを切り替え
  authenticated :user do
    root "goals#index", as: :authenticated_root
  end

  unauthenticated do
    root "home#index", as: :unauthenticated_root
  end

  # Goal（目標）と、その配下に Progress・Comment をネスト
  resources :goals do
    resources :progresses, only: [:create]
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  # 投稿機能
  resources :posts

  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check

  # 利用規約ページ
  get "terms", to: "pages#terms"
end

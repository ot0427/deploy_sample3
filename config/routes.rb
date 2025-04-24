Rails.application.routes.draw do
  # ユーザー認証用（Devise）
  devise_for :users

  # Goal（目標）と、その配下に Progress（進捗）をネスト
  resources :goals do
    resources :progresses, only: [ :create ]
  end

  # 投稿機能（もし Posts を使うならそのまま）
  resources :posts

  # ヘルスチェック用
  get "up" => "rails/health#show", as: :rails_health_check

  # トップページ
  root "goals#index"
end

class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :set_default_meta
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 見つからないレコードは統一して404を返す
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :terms_accepted ])
  end

  private

  def render_404
    render file: Rails.root.join("public/404.html"), status: :not_found, layout: false
  end

  def set_default_meta
    # 絶対URLを作るために request.base_url を付与
    og_image = "#{request.base_url}#{view_context.image_path('ogp.png')}"

    set_meta_tags(
      site: "MyGoalLog",
      reverse: true,
      description: "手書き風フォームで金銭目標を投稿。応援（♡・コメント）と円グラフで進捗を確認できるサービス。",
      og: {
        type: "website",
        url: request.base_url,
        image: og_image
      },
      twitter: { card: "summary_large_image" }
    )
  end
end

class GoalsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_goal, only: [:show]
  before_action :set_owner_goal, only: [:edit, :update, :destroy]

  def index
    if user_signed_in?
      # 公開されているもの or 自分の投稿を表示
      @goals = Goal.where("is_published = ? OR user_id = ?", true, current_user.id)
                   .order(created_at: :desc)
    else
      # 未ログインは公開されているものだけ
      @goals = Goal.where(is_published: true).order(created_at: :desc)
    end
  end

  def show
    # 進捗率の取得（最新の1件）
    @progress_value = @goal.progresses.order(created_at: :desc)
                                      .limit(1)
                                      .pluck(:value)
                                      .first
                                      .to_i
  end

  def new
    @goal = current_user.goals.build
  end

  def create
    @goal = current_user.goals.build(goal_params)
    if @goal.save
      redirect_to @goal, notice: "目標を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @goal.update(goal_params)
      redirect_to @goal, notice: "目標を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @goal.destroy
    redirect_to goals_path, notice: "目標を削除しました"
  end

  private

  # show用（非公開は本人しか見れない、他人は404）
  def set_goal
    @goal = Goal.find_by(id: params[:id])

    if @goal.nil?
      render file: Rails.root.join("public/404.html"), status: :not_found, layout: false
    elsif !@goal.is_published && (!user_signed_in? || @goal.user != current_user)
      # 非公開かつ本人じゃない場合は 404 を返す
      render file: Rails.root.join("public/404.html"), status: :not_found, layout: false
    end
  end

  # 本人専用（編集・削除用）
  def set_owner_goal
    @goal = current_user.goals.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to goals_path, alert: "権限がありません"
  end

  def goal_params
    params.require(:goal).permit(:title, :description, :image, :is_published)
  end
end

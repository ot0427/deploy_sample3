class GoalsController < ApplicationController
  # ログイン不要: index, show
  before_action :authenticate_user!, except: [:index, :show]
  # 誰でも見られる Goal の取得
  before_action :set_goal, only: [:show]
  # オーナー確認: edit, update, destroy
  before_action :set_owner_goal, only: [:edit, :update, :destroy]

  def index
    @goals = Goal.all.order(created_at: :desc)
  end

  def show
    @progress_value = @goal.progresses
                           .order(created_at: :desc)
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
      render :new
    end
  end

  def edit
    # @goal は set_owner_goal で current_user.goals から取得済
  end

  def update
    if @goal.update(goal_params)
      redirect_to @goal, notice: "目標を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @goal.destroy
    redirect_to goals_path, notice: "目標を削除しました"
  end

  private

  # 誰でも取得可能
  def set_goal
    @goal = Goal.find(params[:id])
  end

  # オーナーのみ取得
  def set_owner_goal
    @goal = current_user.goals.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to goals_path, alert: "権限がありません"
  end

  def goal_params
    params.require(:goal).permit(:title, :description, :image)
  end
end
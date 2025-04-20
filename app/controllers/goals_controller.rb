class GoalsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  def index
    @goals = Goal.all.order(created_at: :desc)
  end

  def show
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
  def set_goal
    @goal = Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:title, :description, :image)
  end
end

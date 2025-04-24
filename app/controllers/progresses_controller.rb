class ProgressesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_goal
    before_action :ensure_owner!
  
    def create
      @progress = @goal.progresses.build(progress_params.merge(user: current_user))
      if @progress.save
        redirect_to @goal, notice: "進捗を登録しました"
      else
        redirect_to @goal, alert: "登録に失敗しました"
      end
    end
  
    private
  
    def set_goal
      @goal = Goal.find(params[:goal_id])
    end
  
    def progress_params
      params.require(:progress).permit(:value, :notes)
    end
  
    # 投稿者（オーナー）だけが進捗を登録できるようにする
    def ensure_owner!
      unless @goal.user == current_user
        redirect_to @goal, alert: "この目標の進捗を登録する権限がありません"
      end
    end
  end
  
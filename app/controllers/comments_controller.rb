# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_goal
  before_action :set_comment, only: [ :edit, :update, :destroy ]

  def create
    @comment = @goal.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to @goal, notice: "コメントを投稿しました"
    else
      redirect_to @goal, alert: "コメント投稿に失敗しました"
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @goal, notice: "コメントを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @goal, notice: "コメントを削除しました"
  end

  private

    def set_goal
      @goal = Goal.find(params[:goal_id])
    end

    def set_comment
      @comment = @goal.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
end

class ProgressesController < ApplicationController
    def create
        @goal = Goal.find(params[:goal_id])
        @progress = @goal.progresses.build(progress_params.merge(user: current_user))
        if @progress.save
          redirect_to @goal, notice: "進捗を登録しました"
        else
          redirect_to @goal, alert: "登録に失敗しました"
        end
      end

      private

      def progress_params
        params.require(:progress).permit(:value, :notes)
    end
end

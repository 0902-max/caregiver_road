class UsersController < ApplicationController
    def reset_score
      current_user.update(score: 0)
      render json: { success: true }
    end
end
  
class CommentsController < ApplicationController

    def create
        @auto = Auto.find(params[:auto_id])
        @comment = @auto.comments.create(:body => params[:body], :user_id => current_user.id, :auto_id => @auto.id)
        redirect_to auto_path(@auto)
    end
    
end

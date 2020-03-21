class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.tweet_id = params[:tweet_id]
  
        if @comment.save
          redirect_back(fallback_location: root_path)
          flash[:commentcreate] = "あなたの言葉でその人は救われるでしょう"
        else
          redirect_back(fallback_location: root_path)
          flash[:commentcreate] = "あなたの言葉でその人は救われるでしょう"
        end
      
      end
  
      def destroy
        Comment.find(params[:tweet_id]).destroy
        redirect_back(fallback_location: root_path)
      end
    
      private
      def comment_params
        params.require(:comment).permit(:content, :name)
      end
end

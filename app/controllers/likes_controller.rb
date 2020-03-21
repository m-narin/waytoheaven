class LikesController < ApplicationController
    def create
      @tweet = Tweet.find(params[:tweet_id])
      @likes = Like.find_by(ip: request.remote_ip.to_s, tweet_id: params[:tweet_id])
      if @tweet.category == "懺悔"
        if @likes
          redirect_back(fallback_location: root_path)
          flash[:likenotice] = "既に赦しています"
        else
          @like = Like.create(tweet_id: params[:tweet_id], ip: request.remote_ip.to_s)
          redirect_back(fallback_location: root_path)
          flash[:likecreate] = "あなたの赦しでその人は救われるでしょう"
        end
      else
        if @likes
          redirect_back(fallback_location: root_path)
          flash[:likenotice] = "既に感謝しています"
        else
          @like = Like.create(tweet_id: params[:tweet_id], ip: request.remote_ip.to_s)
          redirect_back(fallback_location: root_path)
          flash[:likecreate] = "あなたの感謝でその人は救われるでしょう"
        end
      end
    end

      def destroy
        @like = Like.find_by(tweet_id: params[:tweet_id])
        @like.destroy
        redirect_back(fallback_location: root_path)
      end
end

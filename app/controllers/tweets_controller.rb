class TweetsController < ApplicationController

    impressionist :actions=> [:show]
    def zangeindex
      @see = See.find_by(ip: request.remote_ip)
      if @see
        tweet_like_count = Tweet.joins(:likes).group(:tweet_id).count
        tweet_liked_ids = Hash[tweet_like_count.sort_by{ |_, v| -v }].keys
        @zangetweet_ranking= Tweet.where(id: tweet_liked_ids).where(category: "懺悔").limit(3)
        if params[:search]
          #部分検索
          @tweets = Tweet.where("content LIKE ? ",'%' + params[:search] + '%').or(Tweet.where("name LIKE ? ", "%" + params[:search] + "%")).order(created_at: :desc).page(params[:page]).per(7)
        else
          @tweets= Tweet.all.order(created_at: :desc).page(params[:page]).per(7)
        end

      else
        See.create(ip: request.remote_ip)
        tweet_like_count = Tweet.joins(:likes).group(:tweet_id).count
        tweet_liked_ids = Hash[tweet_like_count.sort_by{ |_, v| -v }].keys
        @zangetweet_ranking= Tweet.where(id: tweet_liked_ids).where(category: "懺悔").limit(3)
        if params[:search]
          #部分検索
          @tweets = Tweet.where("content LIKE ? ",'%' + params[:search] + '%').or(Tweet.where("name LIKE ? ", "%" + params[:search] + "%")).order(created_at: :desc).page(params[:page]).per(7)
        else
          @tweets= Tweet.all.order(created_at: :desc).page(params[:page]).per(7)
        end

      end
    end
  
    def zenkouindex
      @see = See.find_by(ip: request.remote_ip)
      if @see 
        tweet_like_count = Tweet.joins(:likes).group(:tweet_id).count
        tweet_liked_ids = Hash[tweet_like_count.sort_by{ |_, v| -v }].keys
        @zenkoutweet_ranking= Tweet.where(id: tweet_liked_ids).where(category: "善行").limit(3)
        if params[:search]
          #部分検索
          @tweets = Tweet.where("content LIKE ? ",'%' + params[:search] + '%').or(Tweet.where("name LIKE ? ", "%" + params[:search] + "%")).order(created_at: :desc).page(params[:page]).per(7)
        else
          @tweets= Tweet.all.order(created_at: :desc).page(params[:page]).per(7)
        end

      else
        tweet_like_count = Tweet.joins(:likes).group(:tweet_id).count
        tweet_liked_ids = Hash[tweet_like_count.sort_by{ |_, v| -v }].keys
        @zenkoutweet_ranking= Tweet.where(id: tweet_liked_ids).where(category: "善行").limit(3)
        if params[:search]
          #部分検索
          @tweets = Tweet.where("content LIKE ? ",'%' + params[:search] + '%').or(Tweet.where("name LIKE ? ", "%" + params[:search] + "%")).order(created_at: :desc).page(params[:page]).per(7)
        else
          @tweets= Tweet.all.order(created_at: :desc).page(params[:page]).per(7)
        end
      end
    end
  
      def zangenew
        @tweet = Tweet.new
      end
  
      def zenkounew
        @tweet = Tweet.new
      end
  
      def show
        
        @tweet = Tweet.find(params[:id])
        @comments = @tweet.comments
        @comment = Comment.new
        @like = Like.new
        impressionist(@tweet, nil, unique: [:impressionable_id, :ip_address])
      end
  
      def create
        @tweet = Tweet.new(tweet_params)
        @tweet.hellnumber = rand(7)
        @tweet.heavennumber = rand(1..5)
        if @tweet.save and @tweet.category == "善行" 
            redirect_to action: "zenkouindex"
            flash[:zenkoucreate] = "あなたの善行はきっと感謝されるでしょう"
        elsif @tweet.save and @tweet.category == "懺悔" 
            redirect_to action: "zangeindex", :alert =>"あなたの懺悔はきっと赦されるでしょう"
            flash[:zangecreate] = "あなたの懺悔はきっと赦されるでしょう"
        else
          redirect_back(fallback_location: root_path)
          flash[:notsave] = "保存できませんでした"
        end
      end
  
      
      def destroy
        @tweet = Tweet.find(params[:id])
        if @tweet.deletekey == params[:key] and @tweet.category == "懺悔"
          @tweet.destroy
          redirect_to action: "zangeindex"
          flash[:tweetdelete] = "懺悔投稿を消しました"
        elsif @tweet.deletekey == params[:key] and @tweet.category == "善行"
          @tweet.destroy
          redirect_to action: "zenkouindex"
          flash[:tweetdelete] = "善行投稿を消しました"
        else 
          redirect_back(fallback_location: root_path)
          flash[:notice] = "削除キーが違います"
        end
      end

      def about
      end

      def hells
      end

      def links
      end

      def heaven
      end
        
         private
         #セキュリティのため、許可したカラムだけ取ってくるようにする
      def tweet_params
        params.require(:tweet).permit(:title, :content, :category, :name, :deletekey)
      end
end

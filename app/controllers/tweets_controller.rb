class TweetsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # check if tweet is set to access edit, update and destroy action
  before_action :set_tweet, only: [:edit, :update, :destroy]

  def index
    @tweets = Current.user.tweets
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Current.user.tweets.new(tweet_params)
    if @tweet.save
      # TweetJob is set auto after_save_commit in model Tweet
      redirect_to tweets_path, success: 'Tweet scheduled successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweets_path, success: 'Tweet updated successfully.'
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path, success: 'Tweet unscheduled.'
  end

  private

  def tweet_params
    params.require(:tweet).permit(:twitter_account_id, :body, :publish_at)
  end

  def set_tweet
    @tweet = Current.user.tweets.find(params[:id])
  end
end
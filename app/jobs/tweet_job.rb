class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    # Do something later

    # if its not the time to publish OR
    # if the tweet publish_at changed and so we cant remove prev jobs rather create new one but to 
    # nullify this old job we return from this without publish
    return if tweet.publish_at > Time.current
    # if tweet been not published only then do the job
    return if tweet.published?

    # if good to go, publish the tweet
    tweet.publish_to_twitter!
  end
end

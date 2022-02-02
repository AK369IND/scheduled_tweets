class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: {minimum: 1, maximum: 280}
  validates :publish_at, presence: true

  # after all initializations and the model is in memory, 
  after_initialize do
    # is this field already exists leave as it is but if empty then change
    self.publish_at ||= 24.hours.from_now
  end

  # after new tweet creation or updataion
  after_save_commit do
    # check if publish time changed
    if publish_at_previously_changed?
      # and put this job in queue to publish only at that time
      TweetJob.set(wait_until: publish_at).perform_later(self)
    end
  end

  def published?
    # if the tweet_id is null it returns false meaning not published yet
    tweet_id?
  end

  def publish_to_twitter!
    tweet_response = twitter_account.client.update(body)
    # client.update is the twitter gem method to publish tweet to twitter
    # update the tweet_id in db which was null before 
    update(tweet_id: tweet_response.id)
  end
end

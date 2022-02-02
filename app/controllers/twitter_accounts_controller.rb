class TwitterAccountsController < ApplicationController

  # this before action would be helpful to write DRY code when we need to find the twitter acc linked
  before_action :set_twitter_account, only: [:destroy]

  def index
    @twitter_accounts = Current.user.twitter_accounts
  end

  def destroy
    @twitter_account.destroy
    redirect_to twitter_accounts_path, success: "Account: #{@twitter_account.nickname} delinked successfully."
    # until the action is not completed, rails keeps the destroyed object in memory and so we can reference it
  end

  private

  def set_twitter_account
    @twitter_account = Current.user.twitter_accounts.find(params[:id])
    # the post request to custom url created by resources: twitter_accounts has the id
    # /twitter_accounts/id
    # and we extracted that id
  end

end
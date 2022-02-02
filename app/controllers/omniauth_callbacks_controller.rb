class OmniauthCallbacksController < ApplicationController
  def twitter
    # see returned user data in logs
    Rails.logger.info auth

    # user model can access twitter_account model
    # query db to find user with this nickname
    # if that exists, give me the first one and I'll update
    # else create a new row of twitter_account and then give me
    twitter_account = Current.user.twitter_accounts.where(nickname: auth.info.nickname).first_or_initialize
    twitter_account.update(
      name: auth.info.name,
      nickname: auth.info.nickname,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.secret
    )

    redirect_to twitter_accounts_path, success: 'Twitter account successfully linked.'
  end

  def auth
    request.env['omniauth.auth']
  end

end
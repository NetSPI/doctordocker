class Api::V1::UsersController < ApplicationController
  skip_before_filter :authenticated
  before_filter :valid_api_token
  before_filter :extrapolate_user

  respond_to :json

  def index
    # We removed the .as_json code from the model, just seemed like extra work.
    # dunno, maybe useful at a later time?
    #respond_with @user.admin ? User.all.as_json : @user.as_json
    respond_with @user.admin ? User.all : @user
  end

  def show
    respond_with @user.as_json
  end

  private

  def valid_api_token
    authenticate_or_request_with_http_token do |token, options|
      # TODO :add some functionality to check if the HTTP Header is valid
      identify_user(token)
    end
  end

  def identify_user(token="")
    # We've had issues with URL encoding, etc. causing issues so just to be safe
    # we will go ahead and unescape the user's token
    unescape_token(token)
    @clean_token =~ /(.*?)-(.*)/
    id = $1
    hash = $2
    (id && hash) ? true : false
    check_hash(id, hash) ? true : false
  end

  def check_hash(id, hash)
    digest = OpenSSL::Digest::SHA1.hexdigest("#{ACCESS_TOKEN_SALT}:#{id}")
    hash == digest
  end

  # We had some issues with the token and url encoding...
  # this is an attempt to normalize the data.
  def unescape_token(token="")
    @clean_token = CGI::unescape(token)
  end

  # Added a method to make it easy to figure out who the user is.
  def extrapolate_user
    @user = User.find_by_id(@clean_token.split("-").first)
  end
end

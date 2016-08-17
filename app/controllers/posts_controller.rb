class PostsController < ApplicationController

  require 'openssl'
  require 'open-uri'

  def index
    @post = Post.new
    @posts = Post.all
  end


  def create
    @post = Post.new(post_params)
    if @post.save
      url = urlBox(@post.url, 'png')
     if @post.update(:url_image => url)
       redirect_to controller: 'posts', action: 'index'
     else
        render 'posts/index', error: 'Failed to Update Url of Post'
     end
    else
      render 'posts/index', error: 'Failed to Create Post'
    end
  end


  def encodeURIComponent(val)
    URI.escape(val, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  end


  def urlBox(url, options={}, format='png')
    urlbox_apikey = 'a8ae0e95-2857-491a-aea1-2038c87b04e5'
    urlbox_secret = '60a0288f-330d-41b2-a374-701e0d7426e5'

    query = {
        :url => url, # required - the url you want to screenshot
        # :force       => options[:force], # optional - boolean - whether you want to generate a new screenshot rather than receive a previously cached one - this also overwrites the previously cached image
        # :full_page   => options[:full_page], # optional - boolean - return a screenshot of the full screen
        # :thumb_width => 250, # optional - number - thumbnail the resulting screenshot using this width in pixels
        # :width       => options[:width], # optional - number - set viewport width to use (in pixels)
        # :height      => options[:height], # optional - number - set viewport height to use (in pixels)
        :quality => 80 # optional - number (0-100) - set quality of the screenshot
    }

    query_string = query.
        sort_by {|s| s[0].to_s }.
        select {|s| s[1] }.
        map {|s| s.map {|v| encodeURIComponent(v.to_s) }.join('=') }.
        join('&')

    token = OpenSSL::HMAC.hexdigest('sha1', urlbox_secret, query_string)

    "https://api.urlbox.io/v1/#{urlbox_apikey}/#{token}/#{format}?#{query_string}"
  end

  ### USAGE: (format can be png or jpg, we default to png) ###
  # url = urlbox("www.google.com", {thumb_width: 200, full_page: true, quality: 90}, 'jpg')
  # puts url
  # url: "https://api.urlbox.io/v1/YOUR_API_KEY/1e6b72c3189da3f4ce8f1f2a0740ddb098e06f84/jpg?full_page=true&quality=90&thumb_width=200&url=www.google.com"
  private
  def post_params
    params.required(:post).permit(:title, :url, :category_id)
  end
end

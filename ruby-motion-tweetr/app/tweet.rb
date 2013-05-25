class Tweet
  attr_accessor :avatar

  def initialize(data)
    @data = data
  end

  def tweet_text 
    @data["text"]
  end

  def username 
    @data["from_user_name"]
  end

  def avatar_url
    @data["profile_image_url"]
  end

  def method_missing(meth, *args, &blk)
    return @data[meth.to_s] if @data.key?(meth.to_s)
    super
  end
end
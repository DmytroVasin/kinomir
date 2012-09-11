module PostsHelper
  def avatar_url(i)
    gravatar_id = Digest::MD5::hexdigest(i.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=58"
  end
end

module ConstructorCore
  module ApplicationHelper
    def gravatar_icon(user_email = '', size = 40)
      gravatar_url = 'http://www.gravatar.com/avatar/%{hash}?s=%{size}&d=mm'
      user_email.strip!
      sprintf gravatar_url, hash: Digest::MD5.hexdigest(user_email.downcase), size: size
    end
  end
end
class User < ActiveRecord::Base
  has_many :websites
  has_secure_password

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

  def tags
    self.websites.collect do |website|
      website.tag
    end.uniq
  end

end

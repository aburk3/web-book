class Website < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag

  def format_url
    if !self.content.include?("http") && !self.content.include?("www")
      self.content.prepend("https://")
    elsif self.content.include?("www.")
      self.content.sub! 'www.', 'https://'
    end
  end
end

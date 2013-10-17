class Status < ActiveRecord::Base
  attr_accessible :body, :link, :pic, :user_id, :company_id

  validate :user_id_or_company_id
  validate :one_field_filled_out
  validate :link_is_ok

  belongs_to :user
  belongs_to :company

  has_many :responses

  has_attached_file :pic, :styles => {
          :big => "610x610>",
          :small => "300x300>"
        }

        def time_ago
          time_ago_in_words(self.created_at) + " ago"
        end

  def is_company_status?
    self.company_id
  end

  def self.statuses_liked_by(current_user)
    Status.joins(:responses).where(
      "responses.body IS NULL AND responses.user_id = ?", 
      current_user.id
      )
  end

  def like_count
    self.responses.where("body IS NULL").count
  end

  def comments
    self.responses.where("body IS NOT NULL")
  end

  def excerpt
    if body
      "status: <div>" + body[0...100] + "</div>"
    elsif link
      "status: <div>" + link + "</div>"
    else
      "photo status"
    end
  end

  private

  def user_id_or_company_id
    unless user_id || company_id
      errors.add(:user_id, "Must belong to user or company")
    end
  end

  def one_field_filled_out
    unless body || link || pic_file_name
      errors.add(:body, "Must have body, link, or image")
    end
  end
  
  def link_is_ok
    return unless link
    
    unless /\A((http:\/\/)|(https:\/\/))?((www\.)|\w+\.)?\w*(\.\w{2,4})\z/
      .match(link)
        errors.add(:link, "Please enter a valid URL")
    end
  end

end

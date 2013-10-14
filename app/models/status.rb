class Status < ActiveRecord::Base
  attr_accessible :body, :link, :pic, :user_id, :company_id

  validate :user_id_or_company_id
  validate :one_field_filled_out


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
      "responses.body IS NULL AND responses.user_id = ?", current_user.id
      )
  end

  def like_count
    self.responses.where("body IS NULL").count
  end

  def comments
    self.responses.where("body IS NOT NULL")
  end

  private

  def user_id_or_company_id
    user_id || company_id
  end

  def one_field_filled_out
    body || link || image_url
  end

end

class Company < ActiveRecord::Base
  attr_accessible :owner, :name, :industry, :address1, :address2, :city,
    :state, :zip, :summary, :null

    #do we need :owner up there?

  validates :name, presence: true

  validates :name, :address1, :address2, :city, :zip, :summary,
    length: { minimum: 1, allow_nil: true }

  validates :state, inclusion: { in: %w(NY CA), allow_nil: true }
  validates :industry, inclusion: { in: [
      "Real Estate",
      "Technology",
      "Advertising",
      "Hospitality",
      "Health/Medicine",
      "Banana Stand",
      "Other"
    ] }

  has_many :memberships
  has_many :members, through: :memberships, source: :member

  has_many :statuses
  has_many :contacts

  has_attached_file :pic, styles: {
    big: "300x300>",
    thumb: "100x100>"
  }, default_url: "/assets/blue-myself.png"

  def null=(field)
    self.send("#{field}=", nil)
  end

  def owner=(owner)
    Membership.create(
      company_id: self.id,
      member_id: owner.id,
      status: 2
    )
  end

  def owner
    self.memberships.each do |membership|
      if membership.status == 2
        return membership.member
      end
    end

    return nil
  end

  def admins
    [].tap do |admins|
      self.memberships.each do |membership|
        if membership.status > 0
          admins << membership.member
        end
      end
    end
  end
end

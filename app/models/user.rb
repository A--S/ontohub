class User < ActiveRecord::Base
  
  include User::Authentication

  has_many :team_users
  has_many :teams, :through => :team_users
  
  attr_accessible :email, :name, :admin, :password, :as => :admin
  
  scope :email_search, ->(term) { where "email ILIKE ?", "%" << term << "%" }
  
  def to_s
    name? ? name : email.split("@").first
  end
  
  # marks the user as deleted
  def delete
    self.encrypted_password = nil
    self.deleted_at = Time.now
    
    # nullify email fields
    @bypass_postpone       = true
    self.email             = nil
    self.unconfirmed_email = nil
    
    save(:validate => false)
  end
  
  def email_required?
    deleted_at.nil?
  end
  
end

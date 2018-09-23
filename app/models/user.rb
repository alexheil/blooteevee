class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged

  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z0-9]+\Z/i }
  validate :validate_username

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login
  attr_accessor :cardholder

  has_one :profile, dependent: :destroy
  has_one :membership, dependent: :destroy
  has_one :merchant, dependent: :destroy
  has_one :plan, dependent: :destroy

  has_many :active_subscriptions, class_name: "Subscription", foreign_key: "subscriber_id", dependent: :destroy
  has_many :passive_subscriptions, class_name: "Subscription", foreign_key: "subscribed_id", dependent: :destroy
  has_many :subscribing, through: :active_subscriptions,  source: :subscribed
  has_many :subscribers, through: :passive_subscriptions, source: :subscriber
  has_many :videos, dependent: :destroy
  # has_many :comments, dependent: :destroy

  before_save :should_generate_new_friendly_id?, if: :username_changed?
  before_save :downcase_username

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def subscribe(other_user)
    subscribing << other_user
  end

  def unsubscribe(other_user)
    subscribing.delete(other_user)
  end

  def subscribing?(other_user)
    subscribing.include?(other_user)
  end

  def feed
    subscribing_ids = "SELECT subscribed_id FROM relationships WHERE  subscriber_id = :user_id"
    Video.where("user_id IN (#{subscribing_ids}) OR user_id = :user_id", user_id: id)
  end

  private

    def should_generate_new_friendly_id?
      username_changed?
    end

    def downcase_username
      self.username = username.downcase
    end

    def subscriber_email
      User.includes(:subscriptions).where(:subscriptions => { subscribed_id: id }).find_each do |sub|
        puts sub.username
      end
    end

end

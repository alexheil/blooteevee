class Video < ApplicationRecord
  extend FriendlyId
  friendly_id :slug, use: :slugged

  include VideoUploader[:video]
  include ImageUploader[:image]

  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :video_data, presence: true, unless: :video_data?
  validates :description, presence: true, length: { maximum: 5000 }

  before_save :generated_slug
    
  private

    def generated_slug
      require 'securerandom' 
      self.slug = SecureRandom.hex(16) if slug.blank?
    end

end

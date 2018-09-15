class Video < ApplicationRecord
  extend FriendlyId
  friendly_id :slug, use: :slugged

  include VideoUploader[:video]
  include ImageUploader[:image]

  belongs_to :user
  belongs_to :category
  #belongs_to :subcategory, optional: true

  has_many :comments, dependent: :destroy

  validates :category_id, presence: true
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

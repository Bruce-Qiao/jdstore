class Product < ApplicationRecord
  validates :title, presence: true
  validates :quantity, numericality: {greater_than: 0}
  validates :price, numericality: {greater_than: 0}
  validates :taoprice, numericality: {greater_than: 0}

  mount_uploader :image, ImageUploader

  belongs_to :user

  has_many :favorites
  has_many :fans, through: :favorites, source: :user

  def increment(by = 1)
    self.views ||= 0
    self.views += by
    self.save
  end

  def public!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

end

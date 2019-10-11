class Post < ActiveRecord::Base
  ENABLE_EXTENSION_REGEXP = /.*\.(jpg|png|jpeg)\z/.freeze
  private_constant(:ENABLE_EXTENSION_REGEXP)

  validates_presence_of :category_id, :thumbnail
  validates :title, length: { in: 1..75 }
  validates :body,  length: { in: 1..20000 }
  validates :thumbnail, format: { with: ENABLE_EXTENSION_REGEXP,
                                  message: 'is only jpg, jpeg, png' }
end

class Course < ActiveRecord::Base
  belongs_to :category
  belongs_to :seller, class_name: 'User', foreign_key: 'user_id'

  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates_presence_of :title, :description, :materials

  validates :title, length: { in: 5..100 }
  validates :description, length: { in: 10..200 }

  validates :video_cost, numericality: { only_integer: true }
  validates :material_cost, numericality: { only_integer: true }

  has_attached_file :featured_image, styles: { 
    large: '600x600', medium: '230x230#', small: '200x200#', thumbnail: '180x180#'
  }
  has_attached_file :image1, styles: { large: '600x600', thumbnail: '180x180#' }
  has_attached_file :image2, styles: { large: '600x600', thumbnail: '180x180#' }

  validates_attachment_content_type :featured_image, content_type: /\Aimage\/.*\Z/
  # validates_attachment_content_type :image1, content_type: /\Aimage\/.*\Z/
  # validates_attachment_content_type :image2, content_type: /\Aimage\/.*\Z/

  private

    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end

end

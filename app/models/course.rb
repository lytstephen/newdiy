class Course < ActiveRecord::Base
  belongs_to :category
  belongs_to :seller, class_name: 'User', foreign_key: 'user_id'

  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates_presence_of :title, :description, :materials

  validates :title, length: { in: 5..200 }
  validates :description, length: { in: 10..200 }

  validates :video_cost, numericality: { only_integer: true }
  validates :material_cost, numericality: { only_integer: true }

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

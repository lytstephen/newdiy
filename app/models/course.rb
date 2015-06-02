class Course < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  validates_presence_of :title, :description, :materials

  validates :title, length: { in: 5..200 }
  validates :description, length: { in: 10..200 }

  validates :video_cost, numericality: { only_integer: true }
  validates :material_cost, numericality: { only_integer: true }

end

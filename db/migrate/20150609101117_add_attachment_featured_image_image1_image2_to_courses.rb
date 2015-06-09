class AddAttachmentFeaturedImageImage1Image2ToCourses < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.attachment :featured_image
      t.attachment :image1
      t.attachment :image2
    end
  end

  def self.down
    remove_attachment :courses, :featured_image
    remove_attachment :courses, :image1
    remove_attachment :courses, :image2
  end
end

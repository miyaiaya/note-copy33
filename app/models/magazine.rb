class Magazine < ApplicationRecord
  belongs_to :user
  has_many :articles
  has_many :notes, through: :articles
  mount_uploader :header_image, ImageUploader


  def adding(note)
    self.articles.find_or_create_by(note_id: note.id)
  end

  def unadding(note)
    article = self.articles.find_by(note_id: note.id)
    article.destroy if article
  end

  def adding?(note)
    self.notes.include?(note)
  end
end

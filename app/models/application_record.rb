class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def validate_picture
    if picture.attached?
      errors.add(:picture, 'Изображение должно иметь формат jpeg или jpg') unless picture.content_type.in?(%w(image/jpeg image/jpg))
    else
      errors.add(:picture, 'Изображение обязательно')
    end
  end
end

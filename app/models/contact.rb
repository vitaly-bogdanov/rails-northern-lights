=begin
  Контактная информация хранится и записывается
  в коренной директории проекта 
  в файл contacts.yml.
=end

class Contact
  attr_accessor :phone, :email, :instagram

  def update_attributes params
    
  end

  # def phone
  #   file[:phone]
  # end
  # def phone= phone
  #   @contacts = YAML.load_file(file_path)
  #   File.write(file_path, @contacts.store(:phone, phone).to_yaml)
  # end

  # def instagram
  #   YAML.load_file(file_path)[:instagram]
  # end
  # def instagram= instagram
  #   @contacts = YAML.load_file(file_path)
  #   File.write(file_path, @contacts.store(:instagram, instagram).to_yaml)
  # end

  # def email
  #   YAML.load_file(file_path)[:email]
  # end
  # def email= email
  #   @contacts = YAML.load_file(file_path)
  #   File.write(file_path, @contacts.store(:email, email).to_yaml)
  # end

  # def all
  #   YAML.load_file(file_path)
  # end

  private
  
end
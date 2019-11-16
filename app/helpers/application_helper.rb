module ApplicationHelper

  def invalid_class model, input_key
    if model.errors.messages[input_key].any?
      'invalid'
    end
  end
  
  def error_message model, input_key
    if model.errors.messages[input_key].any?
      model.errors.messages[input_key].first
    end 
  end
  
end

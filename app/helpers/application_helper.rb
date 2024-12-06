module ApplicationHelper

  def admin_namespace?
    controller_path.split('/').first == 'admin'
  end

  def public_namespace?
    controller_path.split('/').first == 'public'
  end
  
end

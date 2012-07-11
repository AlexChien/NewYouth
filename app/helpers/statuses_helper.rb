module StatusesHelper
  def current_class(node)
    type = params[:type] || 'raw'
    'current' if type == node
  end
end

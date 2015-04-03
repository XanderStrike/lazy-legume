module ApplicationHelper
  def bootstrap_alert type, message
    <<-HTML
    <div class="alert alert-#{type} alert-dismissible" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      #{message}
    </div>
    HTML
  end
end

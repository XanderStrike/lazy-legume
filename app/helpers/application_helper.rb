module ApplicationHelper
  def bootstrap_alert(type, message)
    <<-HTML
    <div class="alert alert-#{type} alert-dismissible" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      #{message}
    </div>
    HTML
  end

  def truncate(str, n)
    "#{ str[0..(n - 4)] }#{'...' unless str.size < n - 4}"
  end

  def readable_timestamp(t)
    t.localtime.strftime('%D %r')
  end

  def orblank(data)
    data.blank? ? '--' : data
  end
end

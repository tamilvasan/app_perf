class MemoryReporter < Reporter

  def render
    view_context.area_chart(report_data, report_options)
  end

  private

  def report_data
    data = application.analytic_event_data.where(:name => "Memory")

    [{
      :name => "Memory Usage",
      :data => data.group_by_minute(:timestamp, range: time_range).average(:value)
    }]
  end

  def report_colors
    ["#A5FFFF"]
  end

  def report_options
    {
      :id => "memory_chart",
      :height => "100%",
      :library => {
        :colors => report_colors,
        :legend => {
          :position => "bottom"
        },
        :animation => false,
        :xAxis => {
          :plotLines => []
        }
      }
    }
  end
end
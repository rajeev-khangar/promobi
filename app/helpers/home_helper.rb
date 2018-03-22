module HomeHelper
  TOTAL_COLOR = ["#ed5565", "#f8ac59", "#1ab394"]
  
  def pie_chart_by(tasks)
    {
      labels: ['not_started', 'in_progress', 'completed'],
      datasets: [
        {
          background_color: TOTAL_COLOR,
          data: [ tasks.not_started.count, tasks.in_progress.count, tasks.completed.count]
        }
      ]
    }
  end
end



    
import Chart from 'chart.js/auto'

const draw_chart = ()=>{
  document.addEventListener('turbolinks:load', () => {
    if(!document.getElementById('myChart')){
      return
    }
    
    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: JSON.parse(ctx.canvas.dataset.labels),
      datasets: [{
        label: '投稿数',
        data: JSON.parse(ctx.canvas.dataset.data),
        lineTension: 0.3,
      }]
    },
    });
  })

}

export default draw_chart;
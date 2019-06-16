$(document).ready(function(){
    $("#filterGraph").click(function(){
        var chart = Chartkick.charts["chart-1"];
        chart.updateData("/data.json?hours="+ $(event.target).first().children().first().attr('id'));
    });
});
$(document).ready(function() {

  $('#location_toggle').click(function() {
    var src = ($('#location_toggle').attr('src') === '/assets/dropdown_arrow.gif' ? '/assets/dropup_arrow.gif' : '/assets/dropdown_arrow.gif');
    $('#location_toggle').attr('src', src);
    $('#location_dropdown').slideToggle();

    if($('#line_dropdown').css('display') != 'none') {
      $('#line_dropdown').slideUp(100);
      $('#line_toggle').attr('src', '/assets/dropdown_arrow.gif');
    }
  });

  $('#line_toggle').click(function() {
    var src = ($('#line_toggle').attr('src') === '/assets/dropdown_arrow.gif' ? '/assets/dropup_arrow.gif' : '/assets/dropdown_arrow.gif');
    $('#line_toggle').attr('src', src);
    $('#line_dropdown').slideToggle();

    if($('#location_dropdown').css('display') != 'none') {
      $('#location_dropdown').slideUp(100);
      $('#location_toggle').attr('src', '/assets/dropdown_arrow.gif');
    }
  });

  $('#map_toggle').click(function() {
    var src = ($('#map_toggle').attr('src') === '/assets/dropdown_arrow.gif' ? '/assets/dropup_arrow.gif' : '/assets/dropdown_arrow.gif');
    $('#map_toggle').attr('src', src);
    $('#line_map').slideToggle();
    $('#map_status').html( ($('#map_status').html().indexOf("Show") == -1 ? "Show Map" : "Hide Map") )
  });

  $('#location_select').change(function() {
    $('#upcoming_stops').load('/refresh_upcoming/'+this.value)
  });

  $('#line_day_select').change(function() {
    $('#line_stops').load('/refresh_line/'+$('#line_id').html()+'/'+this.value)
  });

  $('#location_day_select').change(function() {
    $('#location_stops').load('/refresh_location/'+$('#location_id').html()+'/'+this.value)
  });

  $('#refresh').click(function() {
    $('#upcoming_stops').load('/refresh_upcoming/'+$('#location_select').attr('value'));
  });

});

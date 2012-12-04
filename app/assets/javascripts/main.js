$(document).ready(function(){

  $('#locations_toggle').click(function() {
    var src = ($('#locations_toggle').attr('src') === '/assets/dropdown_arrow.gif' ? '/assets/dropup_arrow.gif' : '/assets/dropdown_arrow.gif');
    $('#locations_toggle').attr('src', src);
    $('#locations_dropdown').slideToggle();

    if($('#lines_dropdown').css('display') != 'none') {
      $('#lines_dropdown').slideUp(100);
      $('#lines_toggle').attr('src', '/assets/dropdown_arrow.gif');
    }
  });

  $('#lines_toggle').click(function() {
    var src = ($('#lines_toggle').attr('src') === '/assets/dropdown_arrow.gif' ? '/assets/dropup_arrow.gif' : '/assets/dropdown_arrow.gif');
    $('#lines_toggle').attr('src', src);
    $('#lines_dropdown').slideToggle();

    if($('#locations_dropdown').css('display') != 'none') {
      $('#locations_dropdown').slideUp(100);
      $('#locations_toggle').attr('src', '/assets/dropdown_arrow.gif');
    }
  });

  $('#locations_select').change(function() {
    $('#upcoming_stops').load('/refresh/'+this.value)
  });

  $('#refresh').click(function() {
    $('#upcoming_stops').load('/refresh/'+$('#Location').attr('value'));
  });

});

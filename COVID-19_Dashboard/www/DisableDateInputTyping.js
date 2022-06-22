// Disable keyboard input to R Shiny inputs by name
$(document).ready(function(){
  $("#minDate_Cases").attr('onkeydown', 'return false');
  $("#maxDate_Cases").attr('onkeydown', 'return false');
  $("#minDate_Symp").attr('onkeydown', 'return false');
  $("#maxDate_Symp").attr('onkeydown', 'return false');
  $("#minDate_Asymp").attr('onkeydown', 'return false');
  $("#maxDate_Asymp").attr('onkeydown', 'return false');
});
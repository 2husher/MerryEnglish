$(document).ready(function(){
  alert('Hi');
  $('#hide_transl').click(function() {
    $(".translation").toggle(this.checked);
  });
});
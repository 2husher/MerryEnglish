function translate(){
  $("#translate_me").on("click", function(){
    $('.translation').toggle();
  });
}

function sentence(){
  $("#show_sentence").on("click", function(){
    $('.sentence').toggle();
  });
}

$(document).ready(function(){
  //alert('ready');
  translate();
  sentence();
});

$(document).on('page:load',function(){
  //alert('load');
  translate();
  sentence();
});
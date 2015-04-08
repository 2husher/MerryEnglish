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

var entities;
var i;
function by_one(){
  $("#by_one").on("click", function(){
    entities = $('div.entity');
    entities.hide();
    i = 0;
    $('#next_one').show();
    $('#by_one').hide();
    entities.eq(i).show();
    i++;
  });
}

function known_next(){
  $("input[value='Know']").on("click", function(){
    if (i < entities.length){
      entities.eq(i-1).hide();
      entities.eq(i).show();
      i++;
    }
    else{
      entities.eq(i-1).hide();
      $('#next_one').hide();
      i = 0;
      $('#by_one').show();
    }
  });
}

function unknown_next(){
  $("input[value=\"Don't know\"]").on("click", function(){
    if (i < entities.length){
      entities.eq(i-1).hide();
      entities.eq(i).show();
      i++;
    }
    else{
      entities.eq(i-1).hide();
      $('#next_one').hide();
      i = 0;
      $('#by_one').show();
    }
  });
}

function next_one(){
  $("#next_one").on("click", function(){
    if (i < entities.length){
      entities.eq(i-1).hide();
      entities.eq(i).show();
      i++;
    }
    else{
      entities.eq(i-1).hide();
      $('#next_one').hide();
      i = 0;
      $('#by_one').show();
    }
  });
}

function all_at_once(){
  $("#all_at_once").on("click", function(){
    entities = $('div.entity');
    var en_len = entities.length;
    for(var j=0; j< en_len; j++){
      entities.eq(j).show();
    }
    $('#next_one').hide();
    i = 0;
    $('#by_one').show();
  });
}

$(document).ready(function(){
  //alert('ready');
  translate();
  sentence();
  by_one();
  known_next();
  unknown_next();
  next_one();
  all_at_once();
});

$(document).on('page:load',function(){
  //alert('load');
  translate();
  sentence();
  by_one();
  known_next();
  unknown_next();
  next_one();
  all_at_once();
});
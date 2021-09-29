$(document).on('turbolinks:load', function(){
  let icon = document.getElementById('user_icon');
  let menu = document.querySelector('.menu');
  let avatar = document.querySelector('.user_avatar');
  icon.addEventListener('click', function(){
    menu.classList.toggle('display');
    avatar.classList.toggle('display');
  });
});

$(document).on('turbolinks:load', function(){
  $(".input_date").datepicker({
    minDate: '+0',
    beforeShowDay: function(date){
      let start_day = gon.start_day;
      let end_day = gon.end_day;
      let reserved_days = new Array();
      debugger;
      for(let i = 0; i < start_day.length; i++){
        for(let j = new Date(start_day[i]); j <= new Date(end_day[i]); j.setDate(j.getDate(start_day[i])+1)){
          debugger;
          let y = j.getFullYear();
          debugger;
          let m = ("0" + (j.getMonth() + 1)).slice(-2);
          debugger;
          let d = ("0" + j.getDate()).slice(-2);
          debugger;
          let result = y + "/" + m + "/" + d;
          debugger;
          reserved_days.push(result);
          debugger;
        };
      };
      dateFormat = "yy/mm/dd";
      callender = $.datepicker.formatDate(dateFormat, date);
      return [(reserved_days.indexOf(callender) == -1), "", ""];
    }
  });
});

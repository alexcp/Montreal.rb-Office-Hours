$(document).ready(function(){
  $.getJSON("/next_event",function(result){
      var date = new Date(result.date).toString().slice(0,21)
      $("#date").text(date)
  });

  $.getJSON("/attendings",function(users){
    var user_list_template = '<% _.each(list, function(user){ %> <div class="span1">'+
                                                          '<a href="<%= user.url %>">'+
                                                            '<img src="<%= user.avatar %>" class="img-circle" />'+
                                                            '<%= user.username %>'+
                                                          '</a>'+
                                                        '</div> <% } )%>' 

    $("#attending-list").html(_.template(user_list_template, {list:users}))
  });

  if($.cookie('github_signedin')) {
    $('.signup')
      .addClass('btn-danger')
      .html('Cancel Attendance');
  }
});

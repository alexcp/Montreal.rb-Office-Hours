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

  !function(d,s,id){
		var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}
	}(document,"script","twitter-wjs");
});

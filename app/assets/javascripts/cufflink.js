window.Cufflink = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
	  var $left = $('#left');
	  var $center = $('#center');
	  var $right = $('#right');
	  
	  var users = new Cufflink.Collections.Browses();
	  
	  users.fetch({
		  success: function() {
			  new Cufflink.Routers.Browses(
				  users, $left, $center, $right);
			  Backbone.history.start();
		  }, error: function() {
			  console.log("Error.")
		  }
	  })
	  
	  // var users = JSON.parse($("#bootstrapped_users_json").html());
	  
	  
  }
};


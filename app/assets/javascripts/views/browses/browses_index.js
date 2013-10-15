Cufflink.Views.BrowsesIndex = Backbone.View.extend({
  template: JST['browses/index'],
  
  render: function() {
	  var that = this;
	  that.$el.empty();
	  
	  that.collection.each(function(user) {
	  		  console.log(user.get("first_name"))
	  });
	  
	  return that;
  }

});

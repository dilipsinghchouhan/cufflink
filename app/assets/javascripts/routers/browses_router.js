Cufflink.Routers.Browses = Backbone.Router.extend({
	initialize: function(users, $left, $center, $right) {
		this.users = users;
		this.$left = $left;
		this.$center = $center;
		this.$right = $right;
	},
	
	routes: {
		"": "index"
	},
	
	index: function() {
		var browsesIndexView = new Cufflink.Views.BrowsesIndex({
			collection: this.users
		});
		
		this.$left.children().remove()
		this.$left.html(browsesIndexView.render().$el);
	}
	
	
});

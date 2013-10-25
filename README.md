#Cufflink

Hey there! Cufflink is a LinkedIn clone I made to test my skills in Rails and JavaScript. 

Please visit a live demo at http://wwww.CufflinkApp.com. You can either sign up or use the demo login button provided.

Q: Why are all the users Arrested Development characters?
A: Why not?

## Skills Used

* CRUD
* Basic Forms
* User Authentication
* ActionMailer
* Partials/helpers
* Routing
* File Upload (with Paperclip)
* JavaScript (with Namespaces)
* jQuery
* Polymorphic Associations
* Postgres
* Heroku Deployment
* Arrested Development Fandom

## Cool Features

### Live Profile Editing

I have no idea why I decided to make this one of my first features (probably because I'm stupid), but live profile editing wound up being a fun and interesting challenge. The main goal, of course, was to keep my code as DRY as possible, while still accommodating different types of fields (checkboxes, textareas, select boxes, etc.).

You can find most of the JavaScript I used <a href="https://github.com/srhmgn/cufflink/blob/master/app/views/shared/js/_show_and_edit.html.erb">here</a>, with some support from my <a href="https://github.com/srhmgn/cufflink/blob/master/app/views/shared/js/_utilities.html.erb">utilities</a> file.

One cool trick I do is use my data to create a temporary object `obj` to store any changes the user has name to a specific field. I populate `obj` with two pieces of data:

* `fieldVal` - This captures whatever is currently in the field when the user clicks "Save". An example value could be "New York".
* `fieldNameAsHash` - What you would see in a regular form's name tag, i.e. `user[city]`. My code here works on both personal and company profiles, so it can also make `fieldNameAsHash` something like `company[city]` when needed.

Next, I set `obj[fieldNameAsHash] = fieldVal;` and pass it to the server via `$.ajax()`. Pretty cool, huh?

I come up with the appropriate URL for the request by using a `genUrl` helper function. `genURL` takes the `modelType` (ex: "user" or "company", or something nested under them, like "experience") and the urlId (the id of the object to be changed) and returns the URL I need.

Some lines of code have been removed for clarity:

````Ruby
var obj = {};

if (["user", "company"].indexOf(modelType) == -1) {
  urlId = $containingDiv.attr("id");
}

var url = genUrl(modelType, urlId);

// if we're saving
if ($clicked_button.hasClass('save')) {

  var fieldNameAsHash = modelType + "[" + fieldType + "]";

  var fieldVal = $field.val();

  obj[fieldNameAsHash] = fieldVal;

  $.ajax({
    url: url,
    type: "PUT",
    data: obj,
    success: function(data) {
      ...
````

### Likes & Comments

I was in the middle of creating two new models, Like and Comment, when I thought "Wow, these are pretty similar." To stay fly and/or DRY, I decided to create a new Response model instead. Behind the scenes, I classify any Response with an empty body as a like, and any Response with a body as a comment.

From <a href="https://github.com/srhmgn/cufflink/blob/master/app/models/response.rb">response.rb</a>:

````Ruby
def is_like?
  !body
end

def self.likes
  Response.where("responses.body IS NULL")
end

def self.comments
  Response.where("responses.body IS NOT NULL")
end
````

### Messages

I learned another life lesson when setting up my Messages controller. My first thought was to create two actions to display sent and incoming messages:  `messages#sent` and `messages#index`. It later occured to me that this was not super RESTful.

Instead, I decided to use `messages#index` to display both incoming and sent messages, as determined by parameters. Extra parameters can also sort messages in ascending or descending order.

From <a href="https://github.com/srhmgn/cufflink/blob/master/app/controllers/messages_controller.rb">messages_controller.rb</a>:
````Ruby
def index
  @order = params[:order] ? params[:order][-3..-1] : ""
  sort_order = get_order(params[:order])

  if params[:sent]
    @messages = current_user.sent_messages
    @type = "Sent"
  else
    @messages = current_user.received_messages
    @type = "Incoming"
  end

  @messages = @messages.order(sort_order).includes(:user)

  render :index
end
````

### Notifications

Notifications were my first foray into polymorphic associations (which sounded terrifying at first). However, I got them set up with little trouble, so that both my Friendship and Response models can trigger notifications for:

* New connection requests
* Accepted or denied connection requests
* New likes and comments

I kept my Notification model pretty general. It has two fields, `string_1` and `string_2`, which can be used to hold whatever data that particular notification needs. 

I use the `#parse_notification` method in <a href="https://github.com/srhmgn/cufflink/blob/master/app/helpers/notifications_helper.rb">notifications_helper.rb</a> to interpret this data and have it show up in the nav menu dropdown.

## Documentation

I wrote <a href="https://github.com/srhmgn/cufflink/tree/master/spec/models">several rspec tests</a> to confirm my models were working as they should. This allowed me to catch an embarassing amount of problems with my custom validators.

## On The Horizon

What's next for Cufflink?

* Infinite scrolling on the homepage
* More notifications
* (Fake) ads
* More settings
* SDK stuff
* Cool feed algorithm
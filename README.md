#Cufflink

## Link

The link they click to generate the modal is like:

<%= link_to "New Message", new_message_url,
  id: "add-email", class: "gen-modal", remote: true %>

The most important parts there are gen-modal and remote: true

## Controller

My message controller listens for an xhr request like so:

if request.xhr?
  render partial: "new", locals: { reply_recipients: @reply_recipients,
    message: @message }

## Javascript

Then I have stuff like this going on to notice when we successfully receive the above partial

$("body")

  .on("ajax:success", "a.gen-modal", function(event, data) {
    var $modal = $("<div>").addClass("modal").append(data)

    $(".backdrop").show();
    $("header").before($modal);
  })

## Backdrop div

The shaded backgrounded is this one div I have at the bottom of every page. I have it in application.html.erb like so:

<div class="backdrop"></div>
</body>
</html>

## Closing

The form that's in the partial has a "remote: true" attribute as well, but it doesn't have to; if it redirects to a page that page won't have an open modal.

But, if you do use "remote: true", you need a .on("ajax:success", "form.modal-form", function(event, data) function that tells the modal to close.

## My CSS:

div.modal {
  position: fixed;
  width: 500px;
  z-index: 10;
  background-color: #fff;
  padding: 20px;
  left: 50%;
  top: 30%;
  border-radius: 8px;
  margin-left: -270px;
  border: 5px solid #FEEB1E;
  box-shadow: 2px 2px 9px #999;
}

div.backdrop {
  width: 100%;
  height: 100%;
  position: fixed;
  background: black;
  opacity: 0.8;
  filter: alpha(opacity=80);
  z-index: 5;
  top: 0;
  display: none;
}

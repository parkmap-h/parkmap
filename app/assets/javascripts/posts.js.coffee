$ ->
  $message =  $('#message')
  $('#post_photo_photo')
    .fileupload
      dateType: 'json'
      add: (e,data) ->
        data.context = $('<span/>').text('Uploading...').appendTo($message);
        data.submit()
      done: (e,data) ->
        data.context.html('<img src="'+ data.result.photo.thumb_url + '" \>');
      error: (e,data) ->
        $alert = $(".alert")
        $alert.empty()
        console.log(data)
        $.each e.responseJSON, (index,message) ->
          $alert.append($("<p \>").text(message))

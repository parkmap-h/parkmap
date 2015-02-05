$ ->
  $message =  $('#message')
  $('#post_photo_photo')
    .fileupload
      dateType: 'json'
      add: (e,data) ->
        data.context = $('<span/>').text('Uploading...').appendTo($message);
        data.submit()
      done: (e,data) ->
        console.log(data.result)
        data.context.html('<img src="'+ data.result.photo.thumb_url + '" \>');

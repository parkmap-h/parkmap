json.photo do
  json.url @post.photo.url
  json.thumb_url @post.photo.thumb.url
  json.mini_url @post.photo.mini.url
end

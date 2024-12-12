json.items do
  json.array!(@posts) do |post|
    json.id post.id
    json.postPath post_path(post)
    json.title post.title
    json.content post.content
    json.town post.town
    json.fullAddress post.full_address
    json.latitude post.latitude
    json.longitude post.longitude
    json.createdAt l(post.created_at, format: :long)
  end  
end
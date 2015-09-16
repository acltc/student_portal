json.array! @comments do |comment|
  json.id comment.id
  json.text comment.text
  json.created_at comment.created_at.strftime("%m/%d/%Y, %I:%M:%S %p")
  json.user comment.user
end
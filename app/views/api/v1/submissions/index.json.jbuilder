json.array! @submissions do |submission|
  json.id submission.id
  json.answer submission.answer
  json.solution submission.solution
  json.created_at submission.created_at.strftime("%A, %d %b %Y %l:%M %p")
  json.comments submission.comments do |comment|
    json.user comment.user
    json.text comment.text
    json.created_at comment.created_at.strftime("%m-%e-%y, %l:%M %p")
  end
end
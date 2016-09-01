json.array! @submissions do |submission|
  json.id submission.id
  json.answer submission.answer
  json.viewed_by_admin submission.viewed_by_admin
  if submission.solution.path
    json.name submission.solution.path.split("/").last
  elsif
    json.name nil
  end 
  json.created_at submission.created_at.strftime("%m/%d/%Y, %I:%M:%S %p")
end
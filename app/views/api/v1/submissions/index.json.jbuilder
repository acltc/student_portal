json.array! @submissions do |submission|
  json.id submission.id
  json.answer submission.answer
  if submission.solution.path
    json.name submission.solution.path.split("/").last
  elsif
    json.name nil
  end 
  json.created_at submission.created_at.strftime("%m/%d/%Y, %I:%M:%S %p")
end
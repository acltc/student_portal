json.id @submission.id
json.answer @submission.answer
json.viewed_by_admin @submission.viewed_by_admin
json.name @submission.solution.path.split("/").last if @submission.solution.path
json.created_at @submission.created_at.strftime("%m/%d/%Y, %I:%M:%S %p")
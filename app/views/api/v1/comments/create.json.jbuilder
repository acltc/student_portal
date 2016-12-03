json.id @comment.id
json.text @comment.text
json.viewed_by_admin @comment.viewed_by_admin
json.created_at @comment.created_at.strftime("%m/%d/%Y, %I:%M:%S %p")
json.user @comment.user
json.email_failed @email_failed

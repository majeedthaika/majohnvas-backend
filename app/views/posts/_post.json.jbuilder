json.extract! post, :id, :title, :content, :course_id, :author, :created_at, :updated_at
json.url post_url(post, format: :json)

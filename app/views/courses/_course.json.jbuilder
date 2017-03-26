json.extract! course, :course_code, :name, :teacher_id, :created_at, :updated_at
json.url course_url(course, format: :json)

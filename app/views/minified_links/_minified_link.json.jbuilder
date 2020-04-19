json.extract! minified_link, :id, :original_url, :created_at, :updated_at
json.url minified_link_url(minified_link, format: :json)

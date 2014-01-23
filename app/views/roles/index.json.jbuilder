json.array!(@roles) do |role|
  json.extract! role, :id, :id, :name, :status
  json.url role_url(role, format: :json)
end

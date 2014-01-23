json.array!(@deposits) do |deposit|
  json.extract! deposit, :id, :id, :nombre, :monto, :fecha
  json.url deposit_url(deposit, format: :json)
end

json.array!(@deposits) do |deposit|
  json.extract! deposit, :id, :monto, :fecha, :date
  json.url deposit_url(deposit, format: :json)
end

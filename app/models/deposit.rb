class Deposit
  include Mongoid::Document
  field :monto, type: Integer
  field :fecha, type: String
  field :date, type: String
end

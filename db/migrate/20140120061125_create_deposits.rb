class CreateDeposits < ActiveRecord::Migration
  def change
    create_table :deposits do |t|
      t.string :nombre
      t.string :monto
      t.date :fecha

      t.timestamps
    end
  end
end

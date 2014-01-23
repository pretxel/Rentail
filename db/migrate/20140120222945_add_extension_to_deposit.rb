class AddExtensionToDeposit < ActiveRecord::Migration
  def change
    add_column :deposits, :extension, :string
  end
end

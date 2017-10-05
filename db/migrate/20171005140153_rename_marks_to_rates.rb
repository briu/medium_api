class RenameMarksToRates < ActiveRecord::Migration[5.0]
  def change
    rename_table :marks, :rates
  end
end

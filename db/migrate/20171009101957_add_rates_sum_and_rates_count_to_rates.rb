class AddRatesSumAndRatesCountToRates < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :rates_sum, :integer, default: 0
    add_column :posts, :rates_count, :integer, default: 0
  end
end

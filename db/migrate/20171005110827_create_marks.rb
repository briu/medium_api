class CreateMarks < ActiveRecord::Migration[5.0]
  def change
    create_table :marks do |t|
      t.integer :value
      t.integer :post_id, index: true

      t.timestamps
    end
  end
end

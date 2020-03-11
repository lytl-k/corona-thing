class CreateCases < ActiveRecord::Migration[6.0]
  def change
    create_table :cases do |t|
      t.integer :amount
      t.datetime :snapshot

      t.timestamps
    end
  end
end

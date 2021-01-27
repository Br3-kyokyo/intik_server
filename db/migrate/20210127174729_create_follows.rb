class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.references :follow, null: false, foreign_key: true
      t.references :follower, null: false, foreign_key: true

      t.timestamps
    end
  end
end

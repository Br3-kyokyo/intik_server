class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :biography
      t.string :email
      t.boolean :admin, default: false
      t.string :password_digest

      t.timestamps
    end
  end
end
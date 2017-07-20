class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title, null: false,   default: ""
      t.text :body,                   default: ""
      t.boolean :private, null: false, default: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

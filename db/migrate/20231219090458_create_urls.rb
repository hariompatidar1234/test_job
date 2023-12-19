class CreateUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :urls do |t|
      t.text :long_url
      t.string :short_url
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

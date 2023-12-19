class AddColumnToUrls < ActiveRecord::Migration[7.1]
  def change
    add_column :urls, :sanitize_url, :string
  end
end

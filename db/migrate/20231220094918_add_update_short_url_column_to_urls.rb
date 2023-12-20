class AddUpdateShortUrlColumnToUrls < ActiveRecord::Migration[7.1]
  def change
    add_column :urls, :update_short_url, :string
  end
end

class AddDefaultValueToEnabledAttribute < ActiveRecord::Migration
  def change
    change_column :links, :enabled, :boolean, default: true
  end
end

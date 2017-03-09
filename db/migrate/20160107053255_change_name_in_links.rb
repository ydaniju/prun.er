# frozen_string_literal: true
class ChangeNameInLinks < ActiveRecord::Migration
  def change
    rename_column :links, :name, :url_input
  end
end

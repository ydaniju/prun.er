# frozen_string_literal: true
class AddFullLinkToLinks < ActiveRecord::Migration
  def change
    add_column :links, :full_link, :string
  end
end

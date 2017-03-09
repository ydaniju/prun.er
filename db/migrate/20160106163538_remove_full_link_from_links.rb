# frozen_string_literal: true
class RemoveFullLinkFromLinks < ActiveRecord::Migration
  def change
    remove_column :links, :full_link, :string
  end
end

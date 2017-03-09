# frozen_string_literal: true
class AddErasedToLinks < ActiveRecord::Migration
  def change
    add_column :links, :erased, :boolean
  end
end

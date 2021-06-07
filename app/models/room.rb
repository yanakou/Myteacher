class Room < ApplicationRecord
  # messages-------------------------------------------------------------------
  has_many :messages
  has_many :entries
  has_many :users, through: :entries
  # notifications-------------------------------------------------------------------
  has_many :notifications
end

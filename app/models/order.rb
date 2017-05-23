class Order < ApplicationRecord

  include AASM
  attr_accessor :active_admin_requested_event
  validates :name, presence: true

  sync :all

  aasm do
    state :pending, :initial => true
    state :received, :brewing, :completed

    event :receive do
      transitions :from => :pending, :to => :received
    end

    event :brew do
      transitions :from => :received, :to => :brewing
    end

    event :complete do
      transitions :from => :brewing, :to => :completed
    end

    event :undo do
      transitions :from => [:brewing, :received, :completed], :to => :pending
    end

  end

end

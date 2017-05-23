class Order < ApplicationRecord

  include AASM
  attr_accessor :active_admin_requested_event
  validates :name, presence: true

  sync :all

  aasm do
    state :received, :initial => true
    state :brewing, :completed

    event :brew do
      transitions :from => :received, :to => :brewing
    end

    event :complete do
      transitions :from => :brewing, :to => :completed
    end

    event :undo do
      transitions :from => [:brewing, :completed], :to => :received
    end

  end

end

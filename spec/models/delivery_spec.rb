require 'spec_helper'

describe Delivery do

  describe "#unread?" do
    it "knows when a message is unread" do
      delivery = Delivery.new(message_id: 1, user_id: 1)

      expect(delivery.unread?).to be_true
    end

    it "know when a message is read" do
      delivery = Delivery.new(message_id: 1, user_id: 1)
      delivery.unread = false

      expect(delivery.unread?).to be_false
    end
  end

  describe "#mark_as_read!" do
    it "marks a delivery as read" do
      delivery = Delivery.new(message_id: 1, user_id: 1)

      delivery.mark_as_read!

      expect(delivery.unread?).to be_false
    end
  end

end
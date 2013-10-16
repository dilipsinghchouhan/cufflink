require 'spec_helper'

describe User do
  subject(:user) { User.new(first_name: "Bob", last_name: "Smith") }

  it "accepts a valid email address" do
    user = User.new(email: "bob.smith@gmail.com")

    user.valid?
    expect(user.errors.messages.keys).to_not include(:email)
  end

  it "catches invalid email addresses" do
    user = User.new(email: "b!b.smith@gmail.com")

    user.valid?
    expect(user.errors.messages.keys).to include(:email)

    user = User.new(email: "bob.smithgmail.com")

    user.valid?
    expect(user.errors.messages.keys).to include(:email)

    user = User.new(email: "_bob.smith@gmail.com")

    user.valid?
    expect(user.errors.messages.keys).to include(:email)
  end

  describe "#name" do
    it "parses full name" do
      expect(user.name).to eq("Bob Smith")
    end
  end

end

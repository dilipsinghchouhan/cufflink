require 'spec_helper'

describe Contact do

  describe "#validates_contact_fields" do
    it "validates a valid email" do
      contact = Contact.new(
        user_id: 2,
        value: "bob@gmail.com",
        contact_type: 0
        )

      expect(contact).to be_valid
    end

    it "reports an error for an invalid email" do
      contact = Contact.new(
        user_id: 2,
        value: "1b!ob@gmail.com",
        contact_type: 0
        )

      expect(contact).to_not be_valid
    end

    it "validates a valid phone number" do
      contact = Contact.new(
        user_id: 2,
        value: "2223334455",
        contact_type: 1
        )

      expect(contact).to be_valid

      contact = Contact.new(
        user_id: 2,
        value: "1-800-449-2400",
        contact_type: 1
        )

      expect(contact).to be_valid

      contact = Contact.new(
        user_id: 2,
        value: "800-449-2400",
        contact_type: 1
        )

      expect(contact).to be_valid

      contact = Contact.new(
        user_id: 2,
        value: "268.888.1234",
        contact_type: 1
        )

      expect(contact).to be_valid
    end

    it "reports an error for an invalid phone number" do
      contact = Contact.new(
        user_id: 2,
        value: "222334455",
        contact_type: 1
        )

      expect(contact).to_not be_valid

      contact = Contact.new(
        user_id: 2,
        value: "1-800-449-240",
        contact_type: 1
        )

      expect(contact).to_not be_valid

      contact = Contact.new(
        user_id: 2,
        value: "268.888.123",
        contact_type: 1
        )

      expect(contact).to_not be_valid

      contact = Contact.new(
        user_id: 2,
        value: "268.888..1234",
        contact_type: 1
        )

      expect(contact).to_not be_valid

      contact = Contact.new(
        user_id: 2,
        value: "11-222-333-4455",
        contact_type: 1
        )

      expect(contact).to_not be_valid
    end

    it "validates a website" do
      contact = Contact.new(
        user_id: 2,
        value: "www.google.com",
        contact_type: 2
        )

      expect(contact).to be_valid

      contact = Contact.new(
        user_id: 2,
        value: "http://www.google.com",
        contact_type: 2
        )

      expect(contact).to be_valid

      contact = Contact.new(
        user_id: 2,
        value: "google.com",
        contact_type: 2
        )

      expect(contact).to be_valid

      contact = Contact.new(
        user_id: 2,
        value: "subdomain.google.com",
        contact_type: 2
        )

      expect(contact).to be_valid
    end

    it "reports an error for an invalid url" do
      contact = Contact.new(
        user_id: 2,
        value: "google",
        contact_type: 2
        )

      expect(contact).to_not be_valid

      contact = Contact.new(
        user_id: 2,
        value: "google dot com",
        contact_type: 2
        )

      expect(contact).to_not be_valid

      contact = Contact.new(
        user_id: 2,
        value: "http:google.com",
        contact_type: 2
        )

      expect(contact).to_not be_valid

      contact = Contact.new(
        user_id: 2,
        value: "googlecom",
        contact_type: 2
        )

      expect(contact).to_not be_valid

      contact = Contact.new(
        user_id: 2,
        value: "google.l",
        contact_type: 2
        )

      expect(contact).to_not be_valid
    end
  end

  describe "#user_id_or_company_id" do

    it "validates a contact with a user ID" do
      contact = Contact.new(
        user_id: 2,
        value: "http://www.google.com",
        contact_type: 2
        )

      expect(contact).to be_valid
    end

    it "validates a contact with a company ID" do
      contact = Contact.new(
        company_id: 2,
        value: "http://www.google.com",
        contact_type: 2
        )

      expect(contact).to be_valid

    end

    it "find a contact without a user or company ID to be invalid" do
      contact = Contact.new(
        value: "http://www.google.com",
        contact_type: 2
        )

      expect(contact).to_not be_valid
    end

  end

end
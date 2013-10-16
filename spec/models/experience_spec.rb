require "spec_helper"

describe Experience do

  describe "#no_time_travel" do
    it "accepts valid data" do
      experience = Experience.new(
        start_date: "01-01-2012", end_date: "01-01-2013")

      experience.valid?

      expect(experience.errors.messages[:start_date]).to be_nil
      expect(experience.errors.messages[:end_date]).to be_nil
    end

    it "requires end date to be after start date" do
      experience = Experience.new(
        start_date: "01-01-2012", end_date: "01-01-2011")

      experience.valid?

      expect(experience.errors.messages[:start_date])
        .to eq(["No time travel! Start date must be after end date"])
    end

    it "will not accept a start or end date in THE FUTURE" do
      experience = Experience.new(start_date: "01-01-2025")

      experience.valid?

      expect(experience.errors.messages[:start_date])
        .to eq(["Dates cannot be in the future"])
    end

    it "catches both errors at once" do
      experience = Experience.new(
        start_date: "01-01-2090", end_date: "01-01-2011")

      experience.valid?

      expect(experience.errors.messages[:start_date])
        .to eq(["Dates cannot be in the future", "No time travel! Start date must be after end date"])
    end
  end

  describe "#null=(field)" do
    it "catches blank form inputs and nullifies the relevant data" do
      experience = Experience.new(start_date: "01-01-2012")

      expect(experience.start_date).to_not be_nil

      experience.null = "start_date"

      expect(experience.start_date).to be_nil
    end
  end

end
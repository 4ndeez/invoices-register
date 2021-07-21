require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(first_name: "John",
                                last_name: "Doe",
                                middle_name: "Martin",
                                id: 1314638)}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a first name" do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a last name" do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it "is still valid without a middle name" do
    subject.middle_name = nil
    expect(subject).to be_valid
  end

  it "is not valid without an id number" do
    subject.id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with incorrect first name length" do
    subject.first_name = "X"
    expect(subject).to_not be_valid
  end

  it "is not valid with incorrect last name length" do
    subject.last_name = "Y"
    expect(subject).to_not be_valid
  end

  it "is not valid if id already exist" do
    described_class.create(first_name: "Yan", last_name: "So", id: 1314638)
    expect(subject.save).to be false
  end
end

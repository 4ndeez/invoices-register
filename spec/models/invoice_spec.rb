require 'rails_helper'

RSpec.describe Invoice, type: :model do
  user = User.create(first_name: "Ivan",
                  last_name: "Ivanov",
                  id: 1314648)
  subject { described_class.new(currency: "BYR",
                                amount: 220.20,
                                user_id: user.id)}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid with incorrect currency" do
    subject.currency = "USDD"
    expect(subject).to_not be_valid
  end

  it "is not valid without a user id" do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with non-existent user" do
    subject.user_id = 123
    expect(subject).to_not be_valid
  end

  it "is not valid with negative amount" do
    subject.amount = -100
    expect(subject).to_not be_valid
  end
end

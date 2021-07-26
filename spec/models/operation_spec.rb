require 'rails_helper'

RSpec.describe Operation, type: :model do
  user_receiver = User.create(first_name: "Ivan",
                     last_name: "Ivanov",
                     id: 1314648)
  user_sender = User.create(first_name: "Ivan",
                              last_name: "Ivanov",
                              id: 13146488)
  sender_invoice = Invoice.create(currency: "USD",
                                  user_id: user_sender.id)
  subject { described_class.new(currency: "BYR",
                                amount: 220.20,
                                receiver_id: user_receiver.id,
                                sender_id: user_sender.id)}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid with incorrect currency" do
    subject.currency = "USDD"
    expect(subject).to_not be_valid
  end

  it "is not valid without a receiver" do
    subject.receiver_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with non-existent receiver" do
    subject.receiver_id = 123
    expect(subject).to_not be_valid
  end

  it "is not valid with negative amount" do
    subject.amount = -100
    expect(subject).to_not be_valid
  end

  describe 'between invoices' do
    # to implement
  end
end

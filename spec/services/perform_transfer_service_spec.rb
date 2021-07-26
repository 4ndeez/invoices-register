require 'rails_helper'

RSpec.describe Operations::PerformTransferService, type: :model do
  describe '#call' do
    let(:sender) { User.create(first_name: "John",
                               last_name: "Doe",
                               id: 1314611) }
    let!(:sender_invoice) { sender.invoices.create(currency: "USD",
                                                        amount: 200) }
    let(:receiver) { User.create(first_name: "John",
                                 last_name: "Does",
                                 id: 1314639) }
    let(:params) {{currency: "USD", amount: 20, sender_id: sender.id, receiver_id: receiver.id}}

    it 'subtract sender money, add receiver money, create transactions' do
      Operations::PerformTransferService.new(params).call
      expect(Operation.all.size).to eq 1
      expect(receiver.invoices[0].amount).to eq(20)
    end
  end
end

class Operations::PerformTransferService
  def initialize(params)
    @currency = params[:currency]
    @amount = params[:amount]
    @receiver_id = params[:receiver_id]
    @sender_id = params[:sender_id]
    @receiver_invoice = Invoice.find_by(user_id: @receiver_id,
                               currency: @currency)
    @sender_invoice = Invoice.find_by(user_id: @sender_id,
                                        currency: @currency)
  end

  def call
    # raising error if not enough funds
    raise StandardError, 'insufficient funds on your balance' if @amount > @sender_invoice.amount
    # creating invoice in case receiver does not have any
    if @receiver_invoice.nil?
      @receiver_invoice ||= Invoice.create(user_id: @receiver_id, currency: @currency, amount: 0)
    end
    # creating operations
    operation = Operation.new(receiver_id: @receiver_id,
                              sender_id: @sender_id,
                              amount: @amount,
                              currency: @currency)
    if operation.save
      result = @receiver_invoice.amount + @amount
      @receiver_invoice.update_attribute(:amount, result)
      @sender_invoice.update_attribute(:amount, @sender_invoice.amount - @amount)
    else
      raise StandardError, 'error saving operation'
    end
    @sender_invoice
  end
end


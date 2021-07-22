class Operations::PerformDepositService
  def initialize(params)
    @currency = params[:currency]
    @amount = params[:amount]
    @receiver_id = params[:receiver_id]
    @invoice = Invoice.find_by(user_id: @receiver_id,
                               currency: @currency)
  end

  def call
    # creating invoice in case receiver does not have any
    @invoice ||= Invoice.create(user_id: @receiver_id, currency: @currency, amount: 0) if @invoice.nil?
    # creating operations
    operation = Operation.new(receiver_id: @receiver_id,
                                  amount: @amount,
                                  currency: @currency)
    if operation.save
      result = @invoice.amount + @amount
      @invoice.update_attribute(:amount, result)
    else
      raise StandardError, 'error saving operation'
    end
    @invoice
  end
end

class Reports::GetReportService
  def initialize(params, choice)
    raise Exception.new 'missing datetime params' unless params[:datetime_from] || params[:datetime_to]
    @choice = choice
    @user = User.find_by_id(params[:user_id]) if params[:user_id]
    @datetime_from = params[:datetime_from]
    @datetime_to = params[:datetime_to]
  end

  def call
    case @choice
    when 1
      if @user
        @operations = @user.received_operations.where(sender_id: nil,
                                                      created_at: Time.parse(@datetime_from)..Time.parse(@datetime_to))
        output_by_currency(@operations)
      else
        @operations = Operation.where(sender_id: nil, created_at: Time.parse(@datetime_from)..Time.parse(@datetime_to))
        output_by_currency(@operations)
      end
    when 2
      result = {}
      @operations = Operation.where.not(sender_id: nil)
                             .where(created_at: Time.parse(@datetime_from)..Time.parse(@datetime_to))
      result["min"] = @operations.pluck(:amount).min
      result["max"] = @operations.pluck(:amount).max
      result["avg"] = ("%0.2f" % [@operations.pluck(:amount).sum / @operations.size]).to_f
      result
    else
      raise Exception.new 'Error in service call'
    end
  end

  private

  def currencies(temp)
    temp.pluck(:currency).uniq
  end

  def output_by_currency(operations)
    result = {}
    currencies(operations).each {|c| result[c] = operations.where(currency: c)}
    result
  end

  def check_params(params)
    raise Exception.new 'param missing' if params.values.include? nil
  end
end

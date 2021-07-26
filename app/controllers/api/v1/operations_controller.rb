module Api
  module V1
    class OperationsController < ApplicationController

      # POST /deposit
      def deposit
        render json: Operations::PerformDepositService.new(operation_params).call
      end

      # POST /transfer
      def transfer
        render json: Operations::PerformTransferService.new(operation_params).call
      end

      private
      def operation_params
        params.require(:operation).permit(:currency, :amount, :sender_id, :receiver_id)
      end
    end
  end
end


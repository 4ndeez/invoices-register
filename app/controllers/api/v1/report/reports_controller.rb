module Api
  module V1
    class Report::ReportsController < ApplicationController

      # GET /report/all
      def all
        render json: Reports::GetReportService.new(report_params, 1).call
      end

      # GET /report/min_max_average
      def min_max_average
        render json: Reports::GetReportService.new(report_params, 2).call
      end

      # GET /report/summary
      def summary
        result, invoices = Hash.new, Invoice.all
        invoices.pluck(:currency).uniq.map {|c| result["#{c}"] = invoices.where(currency: c).pluck(:amount).sum}
        render json: result
      end

      private

      def report_params
        params.permit(:user_id, :datetime_from, :datetime_to, :tag)
      end
    end
  end
end



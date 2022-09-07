module Api
  module V1
    class AccountsController < ::ApplicationController
      before_action :set_account

      def transfer
        #this service will check that both sender and receiver are present and thier status is verified.
        #This returns receiver account if verifications done else false
        receiver_account = ::Verification::VerifySenderReceiverService.new(account_params).process!
        if @account && receiver_account
          transaction = @account.apply_transactions(receiver_account, account_params[:amount])
          render json: { transaction: transaction }, status: :ok
        else
          render json: { error: "Can't process this transaction." }, status: :forbidden
        end
      end

      def transaction_history
        transactions = @account.transactions.order(:created_at)
        render json: transactions
      end

      private

      def set_account
        @account = Account.verified_status.find(params[:id])
      end
      
      def account_params
        params.permit(:email, :phone_number, :amount)
      end

    end
  end
end

# frozen_string_literal: true

module Verification
  class VerifySenderReceiverService
    attr_accessor :params

    def initialize(params)
      @params = params
    end

    def process!
      receiver_account = find_receiver_account
      receiver_account&.verified_status? ? receiver_account : false
    end

    private

    def find_receiver_account
      if @params[:receiver_email]
        Account.find_by_email(@params[:receiver_email])
      else
        Account.find_by_phone_number(@params[:receiver_phone_number])
      end
    end
  end
end

# frozen_string_literal: true

require_relative 'Gemfile'

module Bank
  module UserInterfaceComponents

    Logo.display

    loop do
      response = InitialOptions.display_and_get_response
      case response
      when 1
        OpenAccount.display_and_create_account
      when 2
        account = SelectAccount.display_and_return_account
        DepositFunds.display_and_deposit_funds(account)
      when 3
        account = SelectAccount.display_and_return_account
        WithdrawFunds.display_and_withdraw_funds(account)
      when 4
        from_account = SelectAccount.display_and_return_account
        validated_amount = ::Bank::Helpers::ValidatedAmount.display_and_return_amount
        to_account = SelectAccount.display_and_return_account
        TransferFunds.display_and_transfer_funds(from_account, validated_amount, to_account)
      when 5
        DisplayCustomerAccounts.request_name_and_display_accounts
      end
    end
  end
end

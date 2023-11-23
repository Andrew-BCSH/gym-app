# app/helpers/admins/mejiro_coin_helper.rb

module Admins
  module MejiroCoinHelper
    def compare_to_previous(current, previous)
      return 'No data available' if previous.nil?

      change = current - previous
      percentage_change = (change / previous.to_f) * 100
      "#{percentage_change.round(2)}%"
    end
  end
end

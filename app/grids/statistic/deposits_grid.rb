module Statistic
  class DepositsGrid
    include Datagrid
    include Datagrid::Naming
    include Datagrid::ColumnI18n

    scope do
      Deposit.includes(:account).order('created_at DESC')
    end

    filter(:currency, :enum, :select => Deposit.currency.value_options, :default => 1)
    filter(:address_type, :enum, :select => Deposit.address_type.value_options, :default => 100)
    filter(:state, :enum, :select => Deposit.state.value_options, :default => 500)
    filter(:created_at, :datetime, :range => true, :default => proc { [1.day.ago, Time.now]})

    column :member do |model|
      format(model) do 
        link_to model.member, member_path(model.member)
      end
    end
    column :currency do
      self.account.currency_text
    end
    column(:address_type_text)
    column(:amount)
    column(:tx_id) do |deposit|
      deposit.tx_id
    end
    column_i18n(:created_at)
    column(:state_text)
  end
end

module IGMarkets
  class DealingPlatform
    # Provides methods for interacting with working orders. Returned by {DealingPlatform#working_orders}.
    class WorkingOrderMethods
      # Initializes this helper class with the specified dealing platform.
      #
      # @param [DealingPlatform] dealing_platform The dealing platform.
      def initialize(dealing_platform)
        @dealing_platform = dealing_platform
      end

      # Returns all working orders.
      #
      # @return [Array<WorkingOrder>]
      def all
        @dealing_platform.session.get('workingorders', API_VERSION_2).fetch(:working_orders).map do |attributes|
          WorkingOrder.new attributes.fetch(:working_order_data).merge(market: attributes.fetch(:market_data))
        end
      end
    end
  end
end

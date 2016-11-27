module RubyStackoverflow
  class Client
    class ResponseData
      attr_reader :data, :has_more, :error
      attr_reader :items

      def initialize(response, klass)
        if response[:items].nil?
          @error = StackoverflowError.new(response)
        else
          @data = format_data(response[:items], klass)
          @has_more = response[:has_more]
          @items = response[:items]
        end
      end

      def format_data(data, klass)
        RubyStackoverflow::Client.const_get(klass.capitalize).parse_data(data)
      end
    end
  end
end

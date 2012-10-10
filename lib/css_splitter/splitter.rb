module CssSplitter

  class Splitter

    MAX_SELECTORS_DEFAULT = 4095

    class << self
      def split(data, part=1, max_selectors=MAX_SELECTORS_DEFAULT)
        rules = StringIO.new(data).readlines('}')
        return if rules.first.nil?
        charset_statement, rules[0] = rules.first.partition(/^\@charset[^;]+;/)[1,2]
        output = charset_statement
        output << rules[index_for_rule_with_max_selector(rules, max_selectors)..-1].join
        output
      end

      private

      def count_selectors_of_rule(rule)
        rule.partition(/\{/).first.scan(/,/).count.to_i + 1
      end

      def index_for_rule_with_max_selector(rules, max_selectors)
        selectors_count = 0
        rules.each_with_index do |rule, index|
          rule_selectors_count = count_selectors_of_rule(rule)
          selectors_count += rule_selectors_count
          return index if selectors_count > max_selectors
        end
        rules.length -1
      end
    end

  end

end

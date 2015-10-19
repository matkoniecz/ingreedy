module Ingreedy
  class Rationalizer
    def self.rationalize(options)
      new(options).rationalize
    end

    def initialize(options)
      @integer  = options.fetch(:integer, nil)
      @float    = options.fetch(:float, nil)
      @fraction = options.fetch(:fraction, nil)
      @word     = options.fetch(:word, nil)
      @dictionary = options.fetch(:dictionary, Ingreedy.current_dictionary)
    end

    def rationalize
      if @word
        result = rationalize_word
      elsif @fraction
        result = rationalize_fraction
        if @integer
          result += @integer.to_i
        end
      elsif @integer
        result = @integer.to_r
      elsif @float
        result = @float.tr(",", ".").to_r
      end

      result
    end

    private

    attr_reader :dictionary

    def rationalize_fraction
      vulgar_fractions.each do |char, amount|
        @fraction.gsub!(char, amount.to_s)
      end
      @fraction.to_r
    end

    def vulgar_fractions
      dictionary.vulgar_fractions
    end

    def rationalize_word
      dictionary.numbers[@word.downcase]
    end
  end
end

class StringCalculator
	class NegativeGivenError < StandardError
		def initialize(negatives)
			@negatives = negatives
			super()
		end

		def message
			 "negatives not allowed: #{@negatives.join(", ")}"
		end
	end
end
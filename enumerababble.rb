module Enumerababble
	def my_each
		for i in 0...self.length
			yield self[i]
		end
		self
	end

	def my_each_with_index
		for i in 0...self.length
			yield self[i], i
		end
		self
	end

	def my_select
		array = []
		j = 0
		for i in 0...self.length
			if yield self[i]
				puts self[i]
				array[j] = self[i]
				j += 1
			end
		end
		return array
	end

	def my_any?
		tru = 0
		for i in 0...self.length
			if yield self[i]
				tru = 1
			end
		end
		if tru == 1
			return TRUE
		else
			return FALSE
		end
	end

	def my_none?
		tru = 0
		for i in 0...self.length
			

end
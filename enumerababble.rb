module Enumerababble
	def my_each
		return (:my_each).to_enum unless block_given?
		for i in 0...self.length
			yield self[i]
		end
		self
	end

	def my_each_with_index
		return (:my_each_with_index).to_enum unless block_given?
		for i in 0...self.length
			yield self[i], i
		end
		self
	end

	def my_select
		return (:my_select).to_enum unless block_given?
		array = []
		self.each do |x| array.push(x) if yield x end
		return array
	end

	def my_all?
		if block_given?
			self.my_each do |x| return false unless yield x end
		else
			self.my_each do |x| return false unless x end
		end
		return true
	end

	def my_any?
		if block_given?
			self.my_each do |x| return true if yield x end
			return false
		else
			self.my_each do |x| return true if x end
			return false
		end
	end

	def my_none?
		if block_given?
			self.my_each do |x| return false if yield x end
			return true
		else
			self.my_each do |x| return false if x end
			return true
		end
	end

	def my_count(arg = (no_arg_given = true; nil))
		answer = 0
		if block_given?
			self.my_each do |x| answer+=1 if yield x end
		elsif !no_arg_given
			self.my_each do |x| answer+=1 if x==arg end
		else
			answer = self.length
		end
		return answer
	end

	def my_map(arg1 = nil)
		answer = []
		#added the first if statement for the_odin_project challenge number 14 - make map accept a proc
		if arg1.respond_to? :call
			self.each do |x| answer.push(arg1.call x) end
		elsif block_given?
			for i in 0...self.length
				answer[i] = yield self[i]
			end
		else
			return (:my_map).to_enum
		end
		return answer
	end

	def my_inject(arg1= (arg1_check=1; nil), arg2 = (arg2_check = 2; nil))
		answer = self[0]
		if arg1_check == 1 #when only a block is given
			for i in 1...self.length do answer = yield(answer, self[i]) end if block_given?
		elsif arg2_check == 2 && arg1 #when one argument is passed, with or without a block
			if block_given? #if a block is passed
				answer = arg1
				for i in 0...self.length do answer = yield(answer,self[i]) end
			else #if only a symbol (operation) is passed
				self.my_each do |x| answer = answer.send(arg1,x) end
			end
		else #when an inital and a symbol are passed
			answer = arg1
			for i in 0...self.length do answer = answer.send(arg2,self[i]) end
		end
		return answer
	end


end
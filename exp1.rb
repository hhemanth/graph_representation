def speak(n,proc)
   a = proc.call(10)
   puts a.to_s
   puts n
end

p = Proc.new do |num|
      [num]
    end
speak(100,p)


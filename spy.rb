#!/usr/bin/ruby
TIOCSTI = 0x5412

class SystemCall
end

def parse(input)
  #puts "full input = #{input}"
  syscall = input.reverse.split("=").last.reverse.chomp
  str_arg = /(["'])(?:(?=(\\?))\2.)*?\1/.match(input)
  unless( str_arg.is_a? NilClass )
    str_arg = str_arg[0][1..-2]
    if( str_arg == "\\177")
      str_arg = "\b"
    end
    print str_arg
  end
end

IO.popen("strace -p #{ARGV[0]} -s9999 -e read", :err => [:child, :out]) do |io|
  io.each do |line|
   parse line
  end
end

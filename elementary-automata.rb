#!/usr/bin/ruby

$generation = 0

def automata_step (array, g_rule)
	next_auto_state = []
	array.each_with_index do |x, i|
		if i != array.length-1
			next_auto_state[i] = g_rule[array[i-1]*4 + array[i]*2 + array[i+1]*1]
		else
			next_auto_state[i] = g_rule[array[i-1]*4 + array[i]*2 + array[1]*1]
		end
	end
	
	$generation += 1
	return next_auto_state
end

def automata_print (array)
	print "║"
	array.each do |x|
		if x == 0
			print " "
		elsif x == 1
			print "█"
		end
	end
	print "║#{$generation}\n"
end

#####
# Get number of bits the automaton will have
g_bits = -1
while (g_bits < 2 || g_bits > 128)
	print "\nPlease enter how many bits the elementary automata should have (2-128)\n==> "
	g_bits = gets.chomp.to_i
end

#####
# Get the rule, expressed as deciaml number
rule = -1
while (rule < 0 || rule > 255)
	print "\nPlease enter automation rule (0-255)\n==> "
	rule = gets.chomp.to_i
end

#####
# Convert the decimal rule into a binary array
# beware of kludge
g_rule = []
i = 7
while i >= 0
	if 2**i <= rule
		rule -= 2**i
		g_rule.unshift(1)
	else
		g_rule.unshift(0)
	end
	i -= 1
end

print "==< #{g_rule}\n"

curr_auto_state = []
print "\nPlease enter initial automaton state (as a string of 1's and 0's)\nInvalid input will be interpreted as random initialization\n==> "
raw_init = gets.chomp

if (raw_init.length == g_bits)
	print "==< Valid input\n"
	curr_auto_state = raw_init.split("").map { |x| x.to_i }
else
	print "==< Random initialization\n"
	g_bits.times do
		curr_auto_state.push(rand(2))
	end
end

print "==< #{curr_auto_state}\n"

iterations = -1
while iterations != 0
	print "Iterate how many times?\n==> "
	iterations = gets.chomp.to_i
	iterations.times do
		automata_print(curr_auto_state)
		curr_auto_state = automata_step(curr_auto_state, g_rule)
	end
end
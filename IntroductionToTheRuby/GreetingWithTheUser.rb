#2)Поздороваться с пользователем с использованием форматирования
#строки. Спросить какой язык у пользователя любимый, в случае, если это
#ruby, ответить что пользователь подлиза, иначе обязательно ответить, что
#скоро будет ruby и поставить различные комментарии для нескольких
#языков.
name =  "Пользователь"
if ARGV.length > 0
	name = ARGV[0]
end

ARGV.clear

puts "Привет, #{name}!\n "

languages = [
  "Ruby", "Python", "JavaScript", "Java", "C++", "C#", "Go", "Rust", "Swift", "Kotlin", 
  "PHP", "TypeScript", "Perl", "Scala", "Elixir", "Haskell", "C", "Objective-C", "Dart", 
  "R", "MATLAB", "Lua", "Visual Basic", "Fortran", "COBOL", "F#", "Erlang", "Groovy", 
  "Scheme", "Prolog", "Julia", "Crystal", "VimL", "Tcl", "Smalltalk", "Ada", "Pascal", 
  "Racket", "OCaml", "Nim", "Awk", "SAS", "ABAP", "APL", "Lisp", "Xojo", "Hack", 
  "SML (Standard ML)", "Pony", "Red", "Zig", "ActionScript", "Q#", "Scratch", "Bash", 
  "PowerShell", "Delphi", "Forth", "Mercury", "Modula-2", "REXX", "Eiffel", "Chapel", 
  "Fantom", "Monkey C", "Wolfram", "Logo", "J", "Kotlin Native", "VHDL", "Verilog"
]

puts "#{name}, какой у тебя любимый язык программирования?"

favourite_language = gets.chomp

case favourite_language.downcase
when "ruby"
	puts "#{name}, ты подлиза!"
when "fortran"
	puts "#{name}, тебе пора на пенсию."
when "kotlin"
	puts "#{name}, ты фанат мобилок!"
when "pascal"
	puts "#{name}, ты ничего не перепутал?"
else
	if languages.include?(favouriteLanguage)
		puts "#{name}, хороший выбор, но скоро ты познакомишься с Ruby!"
	else 
		puts "Не слышал про такой язык. Тебе следует познакомиться с Ruby!"
	end
end

#3)Продолжение предыдущего задания. Попросить пользователя
#ввести команду языка ruby. И команду OC. Выполнить команду руби и команду операционной системы.

puts 'Введите команду ОС:'

os_command = gets.chomp

puts "Результат выполнения команды ОС:"
puts `#{os_command}`

puts 'Введи команду на языке Ruby:'
ruby_command = gets.chomp

puts "Результат выполнения команды Ruby:"
eval(rubyCommand)
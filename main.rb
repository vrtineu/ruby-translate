# frozen_string_literal: true

require_relative 'translate'

puts 'This software aims to translate a text from one language to another language.'

loop do
  puts 'Please enter the string you want to translate:'
  text_to_translate = gets.chomp.to_s

  puts 'Please enter the language you want to translate from:'
  language_from = gets.chomp.to_s

  puts 'Please enter the language you want to translate to:'
  language_to = gets.chomp.to_s

  translation = Translate.new(text_to_translate, language_from, language_to)

  puts "The translation is: #{translation.translate}"
  puts '*' * 20

  puts 'Do you want to translate another string? (Y/n)'

  gets.chomp.to_s.downcase == 'n' ? break : next
end

# frozen_string_literal: true

require 'date'

def char
  %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]
end

def area_code_generator(area:)
  case area.upcase
  when 'SWANSEA'
    "C#{char[0..10].sample} "
  when 'CARDIFF'
    "C#{char[11..25].sample} "
  when 'BIRMINGHAM'
    "B#{char[0..2].sample} "
  else raise "Invalid area: #{area}"
  end
end

def reg_date_calculator(years:, reg_date:)
  if reg_date.month.between?(1, 2)
    age_id = years + 49
  elsif reg_date.month.between?(3, 8)
    age_id = years
  elsif reg_date.month.between?(9, 12)
    age_id = years + 50
  else
    raise "Invalid month: #{reg_date.month}"
  end
  "#{age_id} "
end

def age_identifier(date:)
  reg_date = Date.parse(date)
  year_of_reg = reg_date.year.digits.reverse
  decade_year = year_of_reg.last(2).join.to_i
  reg_date_calculator(years: decade_year, reg_date: reg_date)
end

def rand_valid_chars
  chars = %w[A B C D E F G H J L N O P Q R S T U V W X Z]
  chars.sample(3).join
end

def vrn_generator(input:)
  area_code = area_code_generator(area: input.last)
  age_id = age_identifier(date: input[2])
  area_code << age_id << rand_valid_chars
end

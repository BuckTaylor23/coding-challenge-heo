# frozen_string_literal: true

require 'date'

def char
  %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]
end

def area_code_generator(area:)
  case area
  when 'swansea'
    "C#{char[0..10].sample} "
  when 'cardiff'
    "C#{char[11..25].sample} "
  when 'birmingham'
    "B#{char[0..2].sample} "
  else raise "Invalid area: #{area}"
  end
end

def age_identifier(date:)
  reg_date = Date.parse(date)
  year_of_reg = reg_date.year.digits.reverse
  millennia = year_of_reg.first
  year = year_of_reg.last
  age_id = reg_date.month == (3..8) ? millennia + year : millennia + 50 + year
  "#{age_id} "
end

def rand_legal_char
  chars = %w[A B C D E F G H J L N O P Q R S T U V W X Z]
  chars.sample(3).join
end

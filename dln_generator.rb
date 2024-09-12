# frozen_string_literal: true

require 'csv'
require_relative 'generator_helper'

vehicle_rows = CSV.read('./vehicles.csv')

generated_registrations = Array.new
london_array = Array.new
swansea_array = Array.new
cardiff_array = Array.new
birmingham_array = Array.new

vehicle_rows.each do |row|

  london_array << row if row.include? 'london'
  swansea_array << row if row.include? 'swansea'
  cardiff_array << row if row.include? 'cardiff'
  birmingham_array << row if row.include? 'birmingham'
  next row if row.include? 'london'

  if row.include? 'make'
    row << 'vehicleRegistrationNumber'
  else
    dln_generator = area_code_generator(area: row.last) << age_identifier(date: row[2]) << rand_legal_char
    row << dln_generator
    generated_registrations << row
  end
end

CSV.open('./new.csv', 'w') do |csv|
  vehicle_rows.each do |row|
    csv << row unless row.include? 'london'
  end
end


puts "Total amount of generated dlns: #{generated_registrations.count}"
puts "Amount of dlns generated for the Swansea area: #{swansea_array.count}"
puts "Amount of dlns generated for the Cardiff area: #{cardiff_array.count}"
puts "Amount of dlns generated for the Birmingham area: #{birmingham_array.count}"
puts "Amount of rows from London skipped: #{london_array.count}"
puts birmingham_array.count + cardiff_array.count + swansea_array.count + london_array.count
puts vehicle_rows.count

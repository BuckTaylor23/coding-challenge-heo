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
  next row if row.include? 'london'

  if row.include? 'make'
    row << 'vehicleRegistrationNumber'
  else
    vrn = vrn_generator(row: row)
    row << vrn
    generated_registrations << row
    swansea_array << row if row.include? 'swansea'
    cardiff_array << row if row.include? 'cardiff'
    birmingham_array << row if row.include? 'birmingham'
  end
end

CSV.open('./new.csv', 'w') do |csv|
  vehicle_rows.each { |row| csv << row unless row.include? 'london' }
end

puts "Number of vehicles from London skipped: #{london_array.count}"
puts "Number of VRNs generated for the Swansea area: #{swansea_array.count}"
puts "Number of VRNs generated for the Cardiff area: #{cardiff_array.count}"
puts "Number of VRNs generated for the Birmingham area: #{birmingham_array.count}"
puts "Total number of VRNs generated: #{generated_registrations.count}"

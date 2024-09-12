# frozen_string_literal: true

require 'csv'
require_relative 'generator_helper'

VALID_AREAS = %w[swansea cardiff birmingham].freeze

vehicle_rows = CSV.read('./vehicles.csv')

generated_registrations = []
invalid_area_array = []
swansea_array = []
cardiff_array = []
birmingham_array = []

vehicle_rows.each do |row|
  row << 'vehicleRegistrationNumber' if row.first == 'make'
  invalid_area_array << row unless VALID_AREAS.include?(row[4])
  next row unless VALID_AREAS.include?(row[4])

  vrn = vrn_generator(input: row)
  row << vrn
  generated_registrations << row
  swansea_array << row if row[4].upcase == 'SWANSEA'
  cardiff_array << row if row[4].upcase == 'CARDIFF'
  birmingham_array << row if row[4].upcase == 'BIRMINGHAM'
end

CSV.open('./new.csv', 'w') do |csv|
  vehicle_rows.each do |row|
    csv << row if VALID_AREAS.include?(row[4]) || row.first == 'make'
  end
end

puts "Number of vehicles from unrecognised areas skipped: #{invalid_area_array.count}"
puts "Number of VRNs generated for the Swansea area: #{swansea_array.count}"
puts "Number of VRNs generated for the Cardiff area: #{cardiff_array.count}"
puts "Number of VRNs generated for the Birmingham area: #{birmingham_array.count}"
puts "Total number of VRNs generated: #{generated_registrations.count}"

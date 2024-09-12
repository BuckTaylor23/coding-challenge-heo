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
  row << 'vehicleRegistrationNumber' if row.include? 'make'
  invalid_area_array << row unless VALID_AREAS.include?(row[4])
  next row unless VALID_AREAS.include?(row[4])

  vrn = vrn_generator(row: row)
  row << vrn
  generated_registrations << row
  swansea_array << row if row.include? 'swansea'
  cardiff_array << row if row.include? 'cardiff'
  birmingham_array << row if row.include? 'birmingham'
end

CSV.open('./new.csv', 'w') do |csv|
  vehicle_rows.each { |row| csv << row unless row.include? 'london' }
end

puts "Number of vehicles from unrecognised areas skipped: #{invalid_area_array.count}"
puts "Number of VRNs generated for the Swansea area: #{swansea_array.count}"
puts "Number of VRNs generated for the Cardiff area: #{cardiff_array.count}"
puts "Number of VRNs generated for the Birmingham area: #{birmingham_array.count}"
puts "Total number of VRNs generated: #{generated_registrations.count}"

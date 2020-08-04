#!/usr/bin/env ruby
#

require 'bamboozled'
require 'daru'

b = Bamboozled.client(subdomain: 'putdomainhere', api_key: 'putapikeyhere')

# Uncomment if you want to see the field names that are available
# f = b.meta.fields  #.map{ |e|a e['name']}
# f.each{|e| puts e}

fields = ['employeeNumber', 'department', 'jobTitle', 'firstName', 'preferredName', 'lastName', 'payRate', 'hireDate', 'reportingTo', 'employmentHistoryStatus']
rep = b.report.custom(fields)

rep1 = rep.reject{|e| e['employmentHistoryStatus'].eql?('Terminated')}

# sigh payRate is actually two columns with the same alias
rep1.each{ |e| 
    e['payRate'], e['currency'] = e['payRate'].split(' ')
    if e['currency'].nil? 
        e['currency'] = e['payRate']
        e['payRate'] = 0
    end
}

df = Daru::DataFrame.new(rep1)
df['monthly'] = Daru::Vector.new(df['payRate'].map{ |e| 
    (e.to_f/12.0).round(2)
})

df.write_csv('mydept.csv')


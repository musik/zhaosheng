#encoding: utf-8
require 'spec_helper'

describe Ynzs do

  it "should fetch page" do
     #Ynzs.new.list 1,false#,:txtSchool=>'昆明铁路机械学校'
      #Ynzs.new.import
  end
  it "should 1-1" do
    data = []
    schools = []
    schools_daimas = []
    schools_with_leixing = []
    schools_with_leibie = []
    l2 = []
    l3 = []
    l4 = [] 
    l12 = []
    File.readlines("#{Rails.root}/tmp/data1.csv").each do |line|
      arr = line.split(',')
      data << arr
      schools_daimas << arr[0]
      schools << arr[1]
      schools_with_leixing << "#{arr[1]}-#{arr[2]}"
      schools_with_leibie << "#{arr[1]}-#{arr[3]}"
      l2 << arr[2]
      l3 << arr[3]
      l4 << arr[4]
      l12 << arr[12]
      puts line if arr[1] != arr[11]
    end
    pp data.size
    pp schools.uniq.size
    schools.uniq.size.should eq(schools_with_leixing.uniq.size)
    pp schools_with_leibie.uniq.size
    pp l2.uniq,l3.uniq,l4.uniq,l12.uniq
  end
end

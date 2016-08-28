class HomeController < ApplicationController

  require 'nokogiri'
  require 'open-uri'

  def index
    results = HTTParty.get("http://techtalentstore.herokuapp.com/products.json")
    @product1 = results[0]["name"]
  end

  def xml_parse
    @doc = Nokogiri::HTML(open("ftp://ftp.fec.gov/FEC/data.fec.gov/candidate_disbursement2016/GA_05.xml"))

    @description = @doc.at('// description').text

    @expense_list = []

    @doc.xpath('//rec_nam').each_with_index do |x,index|
      expense = []
      expense.push(x.text)
      expense.push(@doc.xpath('//dis_amo')[index].text)
      @expense_list.push(expense)
    end
  end
end

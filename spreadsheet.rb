require 'spreadsheet'

book = Spreadsheet::Workbook.new

sheet1 = book.create_worksheet

n = 0
10.times do 
	sheet1[n,0] = 'Test'
	n += 1
end

book.write './followers_list.xls'
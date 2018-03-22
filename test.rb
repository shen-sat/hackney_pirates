require 'rubygems'
require 'twitter'
require 'spreadsheet'

#set up virtual spreadsheet
book = Spreadsheet::Workbook.new
sheet1 = book.create_worksheet

#twitter dev login
client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = "t3F5fBiVwUjsZyzxAcpDWGHF4"
		  config.consumer_secret     = "YjEpZWx5xQYZ8RD82Dbgutd4m7kytoa3H3nvcppAVOy56LmhSe"
		  config.access_token        = "2347401997-3PzoVOwfAUCr5BVQJ4VmyooGGBXSlcMxV433NDs"
		  config.access_token_secret = "kAkks0m2oWbKb2H9z874f6fMEsquH5xvdB6Tdm7CS95CQ"
end

#collect followers
followers = client.followers("HackneyPirates")

#for each follower, list the name and bio
begin
	n = 0
	followers.each do |follower|
		sheet1[n,0] = "#{follower.name}"
		sheet1[n,1] = "#{follower.description}"
		sheet1[n,2] = "#{follower.followers_count}"
		n += 1
	end
rescue Twitter::Error::TooManyRequests => error
  # NOTE: Your process could go to sleep for up to 15 minutes but if you
  # retry any sooner, it will almost certainly fail with the same exception.
  sleep error.rate_limit.reset_in + 1
  retry
end

#write to file
book.write './followers_list.xls'


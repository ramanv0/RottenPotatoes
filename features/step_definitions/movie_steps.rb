Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(title: movie[:title], rating: movie[:rating],
     release_date: movie[:release_date])
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  expect(Movie.count).to eq n_seeds.to_i
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  capture_e1_e2 = page.body.match(/(#{e1}|#{e2})/)
  expect(capture_e1_e2[1]).to eq e1
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split(', ')
  if uncheck == "un"
    ratings.each do |r|
      steps %Q{When I uncheck the \"#{r}\" checkbox}
    end
  else
    ratings.each do |r|
      steps %Q{When I check the \"#{r}\" checkbox}
    end
  end
end

Then /^I should (not )?see the following movies: (.*)$/ do |no, movie_list|
  movies = movie_list.split(', ')
  if no == "not "
    movies.each do |m|
      steps %Q{Then I should not see \"#{m}\"}
    end
  else
    movies.each do |m|
      steps %Q{Then I should see \"#{m}\"}
    end
  end
end

Then /I should see all the movies/ do
  num_rows = page.all('#movies tbody tr').size
  expect(num_rows).to eq Movie.count
end

When /^(?:|I )press ([^"]*)$/ do |button|
  click_button(button)
end

Then /^debug$/ do
  # Use this to write "Then debug" in your scenario to open a console.
   require "byebug"; byebug
  1 # intentionally force debugger context in this method
end

Then /^debug javascript$/ do
  # Use this to write "Then debug" in your scenario to open a JS console
  page.driver.debugger
  1
end

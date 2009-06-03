Given /^I have a valid user with username"([^\"]*)"$/ do|username|
  User.create!(:username => username)
end

Given /^password"([^\"]*)"$/ do|password|
  User.password = password
end

Given /^I have a invalid user with username"([^\"]*)"$/ do|username|
  User.create!(:username => username)
end

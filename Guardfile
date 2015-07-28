guard :shell do
  watch /.*\.rb$/ do |m|
    system('bundle exec rspec spec')
  end

  watch /.*\.rb$/ do |m|
    system('bundle exec yardoc')
  end
end

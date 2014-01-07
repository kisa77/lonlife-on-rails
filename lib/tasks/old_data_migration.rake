namespace :db do
  desc "The migration old content"
  task notice_migration: :environment do
    5.times do
      puts "a"
    end
  end
end

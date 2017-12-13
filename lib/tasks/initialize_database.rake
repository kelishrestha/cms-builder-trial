# frozen_string_literal: true

namespace :db do
  task :choose_initialize do
    p 'Name for database:', '>>'
    db_name = STDIN.gets.strip
    puts 'Choose database:(from list below)'
    db_string = '1. Sqlite,2. Mysql,3. Postgres,4. Mongo'
    db_details = db_string.split(',')
    db_details.each { |ele| puts ele }
    p '>>'
    db_choice = STDIN.gets.strip.to_i
    case db_choice
    when 1..4
      InitializeDatabase.run(db_name, db_details[db_choice - 1].split('. ')[1])
    else
      p 'No proper choice selected!! Rake Aborted!!!' unless (1..4).cover? db_choice
    end
  end
end

# frozen_string_literal: true

# Initialize Database
module InitializeDatabase
  def self.run(db_name, db_choice)
    configuration = "InitializeDatabase::#{db_choice}".constantize.configuration(db_name)
    file_name = './config/database.example.yml'
    File.open(file_name, 'w') do |file|
      file.write configuration.to_yaml
    end
    File.write(file_name, File.open(file_name, &:read).delete('|'))
    p 'Database yaml file successfully created!!'
  end

  # For Sqlite
  module Sqlite
    def self.configuration(db_name)
      "default: &default\n  adapter: sqlite3\n  pool: 5\n  timeout: 5000\n\n"\
      "development:\n  <<: *default\n  database: db/#{db_name}_development.sqlite3\n\n"\
      "test:\n  <<: *default\n  database: db/#{db_name}_test.sqlite3\n\n"\
      "production:\n  <<: *default\n  database: db/#{db_name}_production.sqlite3\n"
    end
  end

  # For Mysql
  module Mysql
    def self.configuration(db_name)
      "default: &default\n  adapter: mysql2\n  encoding: utf8\n  pool: 5\n"\
      "  username: root\n  password:\n  host: localhost\n\n"\
      "development:\n  <<: *default\n  database: #{db_name}_development\n\n"\
      "test:\n  <<: *default\n  database: #{db_name}_test\n\n"\
      "production:\n  <<: *default\n  database: #{db_name}_production\n  username: #{db_name}\n"\
      "  password: <%= ENV['PROJECTNAME_DATABASE_PASSWORD'] %>\n"
    end
  end

  # For Postgres
  module Postgres
    def self.configuration(db_name)
      "defaults: &defaults\n  adapter: postgresql\n  host: <%= ENV['DB_HOST'] %>\n  "\
      "username: <%= ENV['DB_USERNAME'] %>\n  password: <%= ENV['DB_PASSWORD'] %>\n  "\
      "database: <%= ENV['DB_NAME'] %>\n\n"\
      "development:\n  <<: *defaults\n  host: localhost\n  encoding: UTF8\n  username: postgres\n"\
      "  password:\n  database: #{db_name}_development\n\n"\
      "test:\n  <<: *defaults\n  host: localhost\n  encoding: UTF8\n  username: postgres\n  "\
      "password:\n  database: #{db_name}_test\n\n"\
      "production:\n  <<: *defaults\n"
    end
  end

  # For MongoDB
  module Mongo
    def self.configuration(db_name)
      "development:\n  clients:\n    default:\n      database: #{db_name}_development\n"\
      "      hosts:\n        - 127.0.0.1:27017\n"\
      "test:\n  clients:\n    default:\n      database: #{db_name}_test\n"\
      "      hosts:\n        - 127.0.0.1:27017\n      options:\n        read:\n"\
      "          mode: :primary\n        max_pool_size: 1\n\n"\
      "production:\n  clients:\n    default:\n      database: #{db_name}_production\n"\
      "      hosts:\n        - 172.17.51.236\n      options:\n        ssl: true\n"\
      "        ssl_verify: false\n        ssl_cert: <%= ENV['SSL_CERT_PATH']%>\n"\
      "        max_pool_size: 300\n        wait_queue_timeout: 10\n"
    end
  end
end

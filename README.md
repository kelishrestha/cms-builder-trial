# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

    2.3.0

* Database initialization

    You can initialize database with rake command for following database configuration.

        rails db:choose_initialize

* Configuration

    Run `chmod 777 configure` for granting access on configure file.

* How to run the test suite

  **Running RubyCritic with Rspec:**

    CODE_REVIEW=true rspec

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Annotate files:

    To annotate models only:

        annotate --exclude tests,fixtures,factories,serializers

    [How to use annotate?](https://github.com/ctran/annotate_models#usage)

* Generating application secrets file

    To generate secret key base for application, run
    
        bundle exec rake secret

## Installation
This appilcation was developed using Ruby 2.1 and Rails 4.

A live copy is deploy on [heroku](http://young-dawn-2040.herokuapp.com).

To install:
```
    git clone git@github.com:kowusu/donations_app.git
    cd to\donation_app\working\directory
    bundle install
    bundle exec rake db:create
    bundle exec rake db:migrate
    bundle exec rails s
```

## Project
A user (donor) is able to login and create 3 types of donation.
The three being:
   * Physical Item.  (Has dimensions - height, width, weight)
   * Voucher.  (Expiration date)
   * Experience.  (primary contact name, and location - latitude and longitude)

The donor can
- view all their past donations
- is able to view their experience donations on a map (because of the lat and lng stored for experiences)

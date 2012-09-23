Barcamp Garden
==============

The purpose of this tool is to simplify the life of barcamp organizers.

It aims to provide a convenient and simple tool for interacting with the event
before, while and after it has happened.

Before the event:
* managing attending people / watchers
* create etherpads for 

While the event:
* display all media related to the event aggregating & displaying in real-time
  various streams (twitter, facebook, flickr, etc.)
* involve people in brainstorming & workshops reports by dynamically creating
  etherpads on-the-fly & displaying as "currently happening" in the workshop
  grid, on the event page.

After the event:
* get in touch with people you liked ;
* summarize the event with media, attendees, reports, etc.


Setup
-----

Install all required dependencies

  bundle install --path vendor/bundle


Installation

  rake db:migrate
  rake db:setup:admin


Update the database

  rake db:migrate


Credits
-------

![Gnuside](http://www.gnuside.com/wp-content/themes/gnuside-ignition-0.2-1-g0d0a5ed/images/logo-whitebg-128.png)

Got questions? Need help? Tweet at [@gnuside](http://twitter.com/gnuside).

BarcampGarden is maintained and funded by [Gnuside, inc](http://gnuside.com)

The names and logos for thoughtbot are trademarks of Gnuside, inc.

License
-------

BarcampGarden is Copyright © 2012 Gnuside. 
It is free software, and may be redistributed under the terms specified in the LICENSE file.


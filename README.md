Barcamp Garden
==============

The purpose of this tool is to simplify the life of barcamp organizers.

It aims to provide a convenient and simple tool for interacting with the event
before, while and after it has happened.

Before :
* managing attending people / watchers
* create etherpads for 

While :
* display all media related to the event aggregating & displaying in real-time
  various streams (twitter, facebook, flickr, etc.)
* involve people in brainstorming & workshops reports by dynamically creating
  etherpads on-the-fly & displaying as "currently happening" in the workshop
  grid, on the event page.

After :
* get in touch with people you liked ;
* summarize the event with media, attendees, reports, etc.


Setup
-----

Install all required dependencies

  bundle install --path vendor/bundle

  rake db:migrate
  rake db:setup:admin



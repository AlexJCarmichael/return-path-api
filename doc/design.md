# Link Aggregator


## Description

This application is slimed down version of Reddit. Links can be created with a title and a url. Links can be commented on. Both links and comments can be voted on. Votes are either positive ("up") or negative("down") and links are organized by the total of those votes.

## Libraries and technologies

* Ruby 2.3.1
* Rails 5.0.0
* React-rails
* rspec_rails for testing
* factory_girl rails to provide data for testing
* Skeleton CSS for a simple grid and button system

## API design

I chose to make the API to be a link aggregator as it allowed a demonstration of several skills with a small database. Votes are polymorphic so that a single Vote record can correspond to a Link or a Comment record. I was able to use Active Record to write methods that would calculate the aggregate vote count of a record. This allowed me to write methods to display my list of records in a descending order from highest aggregate count.

The controllers are name spaced under api to communicate the fact that they will return JSON. They are further name spaced under v1 so that if major changes are made in a v2 anyone using v1 would not be affected.

## Single Page design

I chose to use React.js to write my single page application in. React allows for a component on a page to change itself depending on requests made of it. This allowed me to write one parent component with many sub components that could show all links, votes, and comments. It also allowed for a user to create records for all three tables.

## Testing

For testing I used rspec. Rspec allows you to have a few more options to test than the built in Ruby and Rails testing framework. To assist in testing I used Thoughbot's factory_girl which creates test data including associations for your object models.

Controller testing tests both successful and failed requests for each of the four controller actions this API allows.

Model testing includes testing each model validator and any model method written.

## Retrospective

If I could start over this code challenge I would try to have an easier single page design. I spent more time then needed on the view for a challenge that was meant to show case an ability to build an API.

If I was using the same view I would spend the time to dry up the react. I originally had one component that would render all of the links, comments, and votes. I split that into three different components to make it easier to change the display.

If I were to make a v2 of this application starting now I would make use of Rails optional parameters. I would use these to allow different sorting of each mass record return. For example I would make it so that you could get links by the lowest vote total first.
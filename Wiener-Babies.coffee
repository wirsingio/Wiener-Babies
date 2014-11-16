@GivenNames = new Mongo.Collection 'given_names'

if Meteor.isClient
  # do nothing
  console.log 'client is listening'

if Meteor.isServer
  Meteor.startup ->
    givenNames = Assets.getText('data/b11-givennames-vie.csv')
    Data.import(givenNames, GivenNames)

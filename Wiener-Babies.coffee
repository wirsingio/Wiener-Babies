if Meteor.isClient
  # do nothing

if Meteor.isServer
  Meteor.startup ->
    Data.import()

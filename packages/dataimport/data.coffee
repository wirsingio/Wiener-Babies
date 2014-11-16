class @Data
  @import: (givenNames, collection) ->
    cleanedGivenNames = givenNames.trim().split("\r")[3..]

    for row in cleanedGivenNames
      relevantAttributes = row.split(';')[-4..]

      entry =
        occurrences: parseInt(relevantAttributes[0])
        name: relevantAttributes[1]
        female: relevantAttributes[2] == '2'
        year: parseInt(relevantAttributes[3])

      collection.upsert entry, entry


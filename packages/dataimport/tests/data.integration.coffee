
describe 'CSV data import', ->

  testCsv = """
    100 h�ufigste Vornamen der Neugeborenen in Wien pro Jahr und Geschlecht;;;;;;;;\r
    100 Most common given names of children born in Vienna per year and sex;;;;;;;;\r
    NUTS1;NUTS2;NUTS3;DISTRICT_CODE;SUB_DISTRICT_CODE;NUMBER;GIVEN_NAME;SEX;REF_YEAR\r
    AT1;AT13;AT130;00000;0000;130;Sophie;2;2013\r
    AT1;AT13;AT130;00000;0000;124;Julius;1;2012\r
    AT1;AT13;AT130;00000;0000;102;Anna;2;2011\r
  """

  beforeEach ->
    @testCollection = new Mongo.Collection null

  it "inserts the given names into the mongo collection", ->

    Data.import testCsv, @testCollection

    # dont fetch ids -> easier to compare later
    results = @testCollection.find({}, fields: _id: 0).fetch()

    expect(results).to.eql [
      { occurrences: 130, name: 'Sophie', female: true, year: 2013 }
      { occurrences: 124, name: 'Julius', female: false, year: 2012 }
      { occurrences: 102, name: 'Anna', female: true, year: 2011 }
    ]

  it "not re-insert existing data", ->

    Data.import testCsv, @testCollection
    Data.import testCsv, @testCollection

    results = @testCollection.find()

    expect(results.count()).to.equal 3

  it "imports new data correctly", ->

    extraData = testCsv + "AT1;AT13;AT130;00000;0000;130;Sophie;2;2014\r"

    Data.import testCsv, @testCollection
    Data.import extraData, @testCollection

    count = @testCollection.find().count()
    query = @testCollection.find { name: 'Sophie', year: 2014 }, fields: _id: 0
    newDocument = query.fetch()[0]

    expect(count).to.equal 4
    expect(newDocument).to.eql occurrences: 130, name: 'Sophie', female: true, year: 2014

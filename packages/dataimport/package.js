Package.describe({
  summary: 'Imports first name CSV from Vienna Open Data'
});

Package.onUse(function(api) {
  api.use([
    'coffeescript'
  ]);

  api.addFiles([
    'data.coffee'
  ], 'server');
});

Package.onTest(function(api) {

  api.use([
    'coffeescript',
    'spacejamio:munit@2.1.1',
    'dataimport'
  ]);

  api.addFiles([
    'tests/data.integration.coffee'
  ], 'server')

});

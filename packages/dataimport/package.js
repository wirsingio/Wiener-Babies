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

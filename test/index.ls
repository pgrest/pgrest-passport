should = (require \chai).should!
expect = (require \chai).expect
{mk-pgrest-fortest} = require \./testlib

require! pgrest
var pgrest-passport, plx

describe 'pgrest-passport', ->
  describe 'posthook-cli-create-plx', -> ``it``
    beforeEach (done) ->
      pgrest-passport := require \..
      pgrest.use pgrest-passport
      pgrest.init-plugins! {argv:{}, cfg:{auth:{enable:true}}}
      _plx <- mk-pgrest-fortest!
      plx := _plx
      done!
    afterEach (done) ->
      <- plx.query "DROP TABLE users;"
      done!
    .. 'should create a users table.', (done) ->
      pgrest.invoke-hook! \posthook-cli-create-plx, null, plx
      res <- plx.query """
      SELECT count(*)
      FROM information_schema.tables
      WHERE table_name = 'users'
      """
      res.0.count.should.eq \1
      done!
  describe 'posthook-cli-create-app', -> ``it``
    .. 'should configure express to use passportjs.', (done) ->
      used = []
      app = do
        use: -> used.push it
      pgrest.invoke-hook! \posthook-cli-create-app, null, app
      used.length.should.eq 6
      done!

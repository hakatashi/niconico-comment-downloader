should = require 'should'

Downloader = require '../'

username = process.env.NICONICO_USERNAME
password = process.env.NICONICO_PASSWORD

describe 'Downloader', ->
	describe 'login', ->
		it 'should be able to log in', (done) ->
			downloader = new Downloader()

			downloader.login
				username: username
				password: password
			, (error) ->
				should(error).be.null()

				done()

request = require 'request'
extend = require 'xtend'
xml2js = require 'xml2js'

URL =
	LOGIN: 'https://secure.nicovideo.jp/secure/login'

class Downloader
	user: null
	pass: null

	constructor: ->
		# Initialize cookie jar
		@jar = request.jar()
		# Initialize request
		@request = request.defaults jar: @jar

	login: (auth, callback) ->
		return @request
			method: 'POST'
			url: URL.LOGIN
			form:
				mail: auth.username
				password: auth.password
		, (error, response, body) =>
			if error
				return callback error, response

			if not (300 <= response.statusCode < 400)
				return callback new Error('Status code is not redirect'), response

			if response.headers.location.indexOf('https://account.nicovideo.jp') isnt -1
				return callback new Error('Invalid auth info'), response

			return callback null, response

module.exports = Downloader

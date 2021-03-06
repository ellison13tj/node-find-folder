# name: index.js
#
# author: 沈维忠 ( Shen Weizhong / Tony Stark )
#
# Last Update: 沈维忠 ( Shen Weizhong / Tony Stark )



'use strict'



_options = undefined



fs            = require 'fs'

glob          = require 'glob'

extend        = require 'xtend'

isObjectBrace = require 'is-object-brace'

isFile        = require 'is-file'

isDir         = require 'is-directory'

isString      = require 'amp-is-string'

isArray       = require 'amp-is-array'

isUndefined   = require 'amp-is-undefined'

ampFilter     = require 'amp-filter'

includes      = require 'amp-contains'

_forEach      = require 'amp-each'

util          = require 'gulp-util'



# @name _default
# @description Default options.
# @type
#	{object} _default
#	{array}  _default.nottraversal
#	{array}  _default.ignore
# @author 沈维忠 ( Tony Stark / Shen Weizhong )
_default =

	nottraversal: ['.git', 'node_modules']

	ignore: []


# @function convertTo_Obj
# @description Convert given string or array to a brace like object.
# @param {(string|string[])} filter - a string or an array data that need to be converted to brace like object
# @returns {object}
# @author 沈维忠 ( Tony Stark / Shen Weizhong )
convertTo_Obj = (filter) ->

	obj = {}

	if isArray filter

		_forEach filter, (_item, _index, _array) ->

			obj[_item] = _index

	else if isString filter

		obj[filter] = 0

	obj



# @function _filter
# @description Filter some unwanted elements from an array.
# @param {array} arr - data need to be converted
# @param {(string|string[])} filter - a string or an array data for filter condition
# @returns {array}
# @author 沈维忠 ( Tony Stark / Shen Weizhong )
_filter = (arr, filter) ->

	exclude = (item) ->

		(item not of convertTo_Obj(filter))

	ampFilter arr, exclude



# @function _readDirFolderCache
# @description Get list of all folders which under some directory.
# @returns {object}
# @author 沈维忠 ( Tony Stark / Shen Weizhong )
_readDirFolderCache = (->

	instance = undefined

	init = ->

		list = fs.readdirSync process.cwd()

		folders = []

		_deal = (_item, _index, _array) ->

			if isDir _item

				folders.push _item

			return

		_forEach list, _deal

		return folders

	return {

        # @instance
		getInstance: ->

			if !instance

				instance = init()

			return instance

	}

)()



# @function traverse_scope
# @description Get top-level directory needs to be traversed.
# @returns {array}
# @author 沈维忠 ( Tony Stark / Shen Weizhong )
traverse_scope = ->

	_filter _readDirFolderCache.getInstance(), _options.nottraversal



# @function ignoreFilter
# @description Filter result need to be ignored.
# @returns {array}
# @author 沈维忠 ( Tony Stark / Shen Weizhong )
ignoreFilter = ->

	_filter arguments[0], _options.ignore



# @function ifExistInRoot
# @description Determine whether there is any relevant folders under the specified directory.
# @returns {boolean}
# @author 沈维忠 ( Tony Stark / Shen Weizhong )
ifExistInRoot = ->

	includes traverse_scope(), arguments[0]



# @function traversal_pattern
# @description Matches zero or more directories and subdirectories searching for matches.
# @param {string} target - name of folder
# @returns {string}
# @author 沈维忠 ( Tony Stark / Shen Weizhong )
traversal_pattern = (target) ->

	if ifExistInRoot target

		pattern = '+(' + _filter(traverse_scope(), target).join('|') + ')/**/' + target

	else

		pattern = '+(' + traverse_scope().join('|') + ')/**/' + target

	return pattern



# @function getFolders
# @description
#   This is the main method.Use just the name of folder to find the folder(s), rather than
#   through given path(s) - To search the targeted directory(s) you want in the whole
#   project，return array type result. Then, you can do anything you want with the result!
#   For batch operations which according to the directory(s).
# @param {string} target - name of folder
# @param {object} options
# @returns {array}
# @author 沈维忠 ( Tony Stark / Shen Weizhong )
getFolders = ->

	target = arguments[0]

	option = arguments[1]

	if not isUndefined option

		if isObjectBrace option

			_options = extend _default, option

	else

		_options = _default

	if isString(target) and not isFile(target)

		traversal_matched = glob.sync traversal_pattern target

		if ifExistInRoot target

			traversal_matched.push target

	return ignoreFilter traversal_matched



# @class FF
# @description
# @param {string} target - name of folder
# @param {object} options
# @returns {array}
# @author 沈维忠 ( Tony Stark / Shen Weizhong )
class FF

    # @constructs
	constructor: (@folderTarget, @searchOptions) ->

		return getFolders @folderTarget, @searchOptions



# @module node-find-folder
module.exports = FF

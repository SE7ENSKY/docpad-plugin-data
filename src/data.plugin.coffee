fs = require 'fs'
YAML = require 'yamljs'

module.exports = (BasePlugin) ->
	class DataPlugin extends BasePlugin
		name: 'data'
		config:
			dataPaths: [ 'data' ]

		renderBefore: (opts) ->
			{templateData} = opts
			docpadConfig = @docpad.getConfig()
			config = docpadConfig.plugins.data
			for dataPath in config.dataPaths
				dataFiles = fs.readdirSync "#{docpadConfig.srcPath}/#{dataPath}"
				for dataFile in dataFiles
					if m = dataFile.match ///^([a-zA-Z][a-zA-Z0-9_]*)\.(json|yaml|yml|coffee|js)$///
						fullFilePath = "#{docpadConfig.srcPath}/#{dataPath}/#{dataFile}"
						templateData[m[1]] = switch m[2]
							when 'json'
								JSON.parse fs.readFileSync fullFilePath, encoding: "utf8"
							when 'yaml', 'yml'
								YAML.parse fs.readFileSync fullFilePath, encoding: "utf8"
							when 'coffee', 'js'
								delete require.cache[require.resolve fullFilePath]
								require fullFilePath
			
			@ # chaining

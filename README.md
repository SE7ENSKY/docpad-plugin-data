docpad-plugin-data
==================

DocPad plugin for simple data files. Loads and parses JSON, YAML, JavaScript, and CoffeeScript files from `src/data/` and stores the contents on `config.templateData`, which makes the data avaliable at `@filename` when rendering documents.

All data are automatically reloaded each time DocPad regenerates.

## Configuration

```cs
docpadConfig = {
  plugins: {
    data: 
      dataPaths: [ 'data' ] # (default)
  # ...
}
module exports = docpadConfig
```

All `dataPaths` are assumed to be subdirs of `docpadConfig.srcPath`, which defaults to `./src/`.

## Requirements

Currently, filenames are restricted to a subset of valid JavaScript variable names: they must begin with a letter, and contain only letters, numbers, or underscores. Files with hyphens, extra dots, or other characters will be ignored.

# Concepts

## Entry

- indicates which module webpack should use to begin building out its internal dependency graph.
- By default its value is ./src/index.js

## Loaders

> `module :: rule :: {test, use}`

- `test`: identifies which file or files should be transformed.
- `use`: property indicates which loader should be used to do the transforming.

## Plugins

In order to use a plugin, you need to require() it and add it to the plugins array

## Output

while there can be multiple `entry` points, only one `output` configuration is specified

- 至少有`filename`属性
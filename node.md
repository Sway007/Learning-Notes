# 

- Node加载包机制
  
  If you provide a folder name as a module, Node looks for a package.json file that contains a main property flagging the module file to load:

  { "name" : "somemodule",
     "main" : "./lib/somemodule.js" }

  If Node can’t find a package.json file, it looks for an index.js or index.node file to load. If all these searches fail, you’ll get an error.
  
"use strict";var FF,ampFilter,convertTo_Obj,extend,fs,getFolders,glob,ifExistInRoot,ignoreFilter,includes,isArray,isDir,isFile,isObjectBrace,isString,isUndefined,traversal_pattern,traverse_scope,util,_default,_filter,_forEach,_options,_readDirFolderCache;_options=void 0,fs=require("fs"),glob=require("glob"),extend=require("xtend"),isObjectBrace=require("is-object-brace"),isFile=require("is-file"),isDir=require("is-directory"),isString=require("amp-is-string"),isArray=require("amp-is-array"),isUndefined=require("amp-is-undefined"),ampFilter=require("amp-filter"),includes=require("amp-contains"),_forEach=require("amp-each"),util=require("gulp-util"),_default={nottraversal:[".git","node_modules"],ignore:[]},convertTo_Obj=function(r){var e;return e={},isArray(r)?_forEach(r,function(r,i){return e[r]=i}):isString(r)&&(e[r]=0),e},_filter=function(r,e){var i;return i=function(r){return!(r in convertTo_Obj(e))},ampFilter(r,i)},_readDirFolderCache=function(){var r,e;return e=void 0,r=function(){var r,e,i;return e=fs.readdirSync(process.cwd()),r=[],i=function(e){isDir(e)&&r.push(e)},_forEach(e,i),r},{getInstance:function(){return e||(e=r()),e}}}(),traverse_scope=function(){return _filter(_readDirFolderCache.getInstance(),_options.nottraversal)},ignoreFilter=function(){return _filter(arguments[0],_options.ignore)},ifExistInRoot=function(){return includes(traverse_scope(),arguments[0])},traversal_pattern=function(r){var e;return e=ifExistInRoot(r)?"+("+_filter(traverse_scope(),r).join("|")+")/**/"+r:"+("+traverse_scope().join("|")+")/**/"+r},getFolders=function(){var r,e,i;return e=arguments[0],r=arguments[1],isUndefined(r)?_options=_default:isObjectBrace(r)&&(_options=extend(_default,r)),isString(e)&&!isFile(e)&&(i=glob.sync(traversal_pattern(e)),ifExistInRoot(e)&&i.push(e)),ignoreFilter(i)},FF=function(){function r(r,e){return this.folderTarget=r,this.searchOptions=e,getFolders(this.folderTarget,this.searchOptions)}return r}(),module.exports=FF;
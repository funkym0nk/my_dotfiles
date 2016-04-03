" Vim syntax file
" Language: YAPL 
" Author: Emanuele Bovisio - ADB Broadband
" Last Change:  March 25, 2011
"
" Options:  yapl_htmlInStrings = 1  for HTML syntax highlighting inside strings
"           yapl_parent_error_close = 1  for highlighting parent error ] or )
"           yapl_parent_error_open = 1  for skipping an yapl end tag, if there exists an open ( or [ without a closing one
"           yapl_oldStyle = 1  for using old colorstyle
"           yapl_folding = 1  for folding classes and functions
"           yapl_folding = 2  for folding all { } regions
"           yapl_sync_method = x
"                             x=-1 to sync by search ( default )
"                             x>0 to sync at least x lines backwards
"                             x=0 to sync from start
"           yapl_special_functions = 1|0 to highlight functions with abnormal behaviour
"           yapl_alt_comparisons = 1|0 to highlight comparison operators in an alternate colour
"           yapl_alt_assignByReference = 1|0 to highlight '= &' in an alternate colour
" Note:     derived from php.vim, several definitions are not present in YAPL, but left for
"           future improvements
"

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'yapl'
endif
if version < 600
  unlet! yapl_folding
  if exists("yapl_sync_method") && !yapl_sync_method
    let yapl_sync_method=-1
  endif
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

" accept old options
if !exists("yapl_sync_method")
  if exists("yapl_minlines")
    let yapl_sync_method=yapl_minlines
  else
    let yapl_sync_method=-1
  endif
endif

if exists("yapl_parentError") && !exists("yapl_parent_error_open") && !exists("yapl_parent_error_close")
  let yapl_parent_error_close=1
  let yapl_parent_error_open=1
endif

syn cluster htmlPreproc add=yaplRegion

syn sync clear

if exists( "yapl_htmlInStrings")
  syn cluster yaplAddStrings add=@htmlTop
endif

syn case match

" Env Variables
syn keyword yaplEnvVar GATEWAY_INTERFACE SERVER_NAME SERVER_SOFTWARE SERVER_PROTOCOL REQUEST_METHOD QUERY_STRING DOCUMENT_ROOT HTTP_ACCEPT HTTP_ACCEPT_CHARSET HTTP_ENCODING HTTP_ACCEPT_LANGUAGE HTTP_CONNECTION HTTP_HOST HTTP_REFERER HTTP_USER_AGENT REMOTE_ADDR REMOTE_PORT SCRIPT_FILENAME SERVER_ADMIN SERVER_PORT SERVER_SIGNATURE PATH_TRANSLATED SCRIPT_NAME REQUEST_URI contained

" Internal Variables
syn keyword yaplIntVar GLOBALS HTTP_GET_VARS HTTP_POST_VARS HTTP_COOKIE_VARS HTTP_POST_FILES HTTP_ENV_VARS HTTP_SERVER_VARS HTTP_SESSION_VARS HTTP_RAW_POST_DATA HTTP_STATE_VARS _GET _POST _COOKIE _FILES _SERVER _ENV _SERVER _REQUEST _SESSION  contained

" Constants
syn keyword yaplCoreConstant DEFAULT_INCLUDE_PATH PEAR_INSTALL_DIR PEAR_EXTENSION_DIR E_ERROR E_WARNING E_PARSE E_NOTICE E_CORE_ERROR E_CORE_WARNING E_COMPILE_ERROR E_COMPILE_WARNING E_USER_ERROR E_USER_WARNING E_USER_NOTICE E_ALL  contained

syn case ignore

syn keyword yaplConstant  __LINE__ __FILE__ __FUNCTION__ __METHOD__ __CLASS__  contained


" Function and Methods 
syn keyword yaplMethods add get geto getmd getv redirect save del source session_check session_put session_new cat session_get objid print set contained
syn keyword yaplFunctions str cm http tpl contained

" Conditional
syn keyword yaplConditional  declare else enddeclare endswitch elseif endif if switch  contained

" Repeat
syn keyword yaplRepeat as do endfor endforeach endwhile for foreach while  contained

" Repeat
syn keyword yaplLabel  case default switch contained

" Statement
syn keyword yaplStatement  return break continue exit  contained

" Keyword
syn keyword yaplKeyword  var const contained

" Type
syn keyword yaplType bool[ean] int[eger] real double float string array object NULL  contained

" Structure
syn keyword yaplStructure  extends implements instanceof parent self contained

" Operator
syn match yaplOperator "[-=+%^&|*!.~?:]" contained display
syn match yaplOperator "[-+*/%^&|.]="  contained display
syn match yaplOperator "/[^*/]"me=e-1  contained display
syn match yaplOperator "\$"  contained display
syn match yaplOperator "&&\|\<and\>" contained display
syn match yaplOperator "||\|\<x\=or\>" contained display
syn match yaplRelation "[!=<>]=" contained display
syn match yaplRelation "[<>]"  contained display
syn match yaplMemberSelector "->"  contained display
syn match yaplVarSelector  "\$"  contained display

" Identifier
syn match yaplIdentifier "$\h\w*"  contained contains=yaplEnvVar,yaplIntVar,yaplVarSelector display
syn match yaplIdentifierSimply "${\h\w*}"  contains=yaplOperator,yaplParent  contained display
syn region  yaplIdentifierComplex  matchgroup=yaplParent start="{\$"rs=e-1 end="}"  contains=yaplIdentifier,yaplMemberSelector,yaplVarSelector,yaplIdentifierComplexP contained extend
syn region  yaplIdentifierComplexP matchgroup=yaplParent start="\[" end="]" contains=@yaplClInside contained

" Methoden
syn match yaplMethodsVar ":\h\w*" contained contains=yaplMethods,yaplMemberSelector display

" Include
syn keyword yaplInclude  include require include_once require_once contained

" Peter Hodge - added 'clone' keyword
" Define
syn keyword yaplDefine new clone contained

" Boolean
syn keyword yaplBoolean  true false  contained

" Number
syn match yaplNumber "-\=\<\d\+\>" contained display
syn match yaplNumber "\<0x\x\{1,8}\>"  contained display

" Float
syn match yaplFloat  "\(-\=\<\d+\|-\=\)\.\d\+\>" contained display

" SpecialChar
syn match yaplSpecialChar  "\\[abcfnrtyv\\]" contained display
syn match yaplSpecialChar  "\\\d\{3}"  contained contains=yaplOctalError display
syn match yaplSpecialChar  "\\x\x\{2}" contained display

" Error
syn match yaplOctalError "[89]"  contained display
if exists("yapl_parent_error_close")
  syn match yaplParentError  "[)\]}]"  contained display
endif

" Todo
syn keyword yaplTodo todo fixme xxx  contained

" Comment
if exists("yapl_parent_error_open")
  syn region  yaplComment  start="/\*" end="\*/" contained contains=yaplTodo
else
  syn region  yaplComment  start="/\*" end="\*/" contained contains=yaplTodo extend
endif
if version >= 600
  syn match yaplComment  "#.\{-}\(?>\|$\)\@="  contained contains=yaplTodo
  syn match yaplComment  "//.\{-}\(?>\|$\)\@=" contained contains=yaplTodo
else
  syn match yaplComment  "#.\{-}$" contained contains=yaplTodo
  syn match yaplComment  "#.\{-}?>"me=e-2  contained contains=yaplTodo
  syn match yaplComment  "//.\{-}$"  contained contains=yaplTodo
  syn match yaplComment  "//.\{-}?>"me=e-2 contained contains=yaplTodo
endif

" String
if exists("yapl_parent_error_open")
  syn region  yaplStringDouble matchgroup=None start=+"+ skip=+\\\\\|\\"+ end=+"+  contains=@yaplAddStrings,yaplIdentifier,yaplSpecialChar,yaplIdentifierSimply,yaplIdentifierComplex contained keepend
  syn region  yaplBacktick matchgroup=None start=+`+ skip=+\\\\\|\\"+ end=+`+  contains=@yaplAddStrings,yaplIdentifier,yaplSpecialChar,yaplIdentifierSimply,yaplIdentifierComplex contained keepend
  syn region  yaplStringSingle matchgroup=None start=+'+ skip=+\\\\\|\\'+ end=+'+  contains=@yaplAddStrings contained keepend
else
  syn region  yaplStringDouble matchgroup=None start=+"+ skip=+\\\\\|\\"+ end=+"+  contains=@yaplAddStrings,yaplIdentifier,yaplSpecialChar,yaplIdentifierSimply,yaplIdentifierComplex contained extend keepend
  syn region  yaplBacktick matchgroup=None start=+`+ skip=+\\\\\|\\"+ end=+`+  contains=@yaplAddStrings,yaplIdentifier,yaplSpecialChar,yaplIdentifierSimply,yaplIdentifierComplex contained extend keepend
  syn region  yaplStringSingle matchgroup=None start=+'+ skip=+\\\\\|\\'+ end=+'+  contains=@yaplAddStrings contained keepend extend
endif

" HereDoc
if version >= 600
  syn case match
  syn region  yaplHereDoc  matchgroup=Delimiter start="\(<<<\)\@<=\z(\I\i*\)$" end="^\z1\(;\=$\)\@=" contained contains=yaplIdentifier,yaplIdentifierSimply,yaplIdentifierComplex,yaplSpecialChar,yaplMethodsVar keepend extend
" including HTML,JavaScript,SQL even if not enabled via options
  syn region  yaplHereDoc  matchgroup=Delimiter start="\(<<<\)\@<=\z(\(\I\i*\)\=\(html\)\c\(\i*\)\)$" end="^\z1\(;\=$\)\@="  contained contains=@htmlTop,yaplIdentifier,yaplIdentifierSimply,yaplIdentifierComplex,yaplSpecialChar,yaplMethodsVar keepend extend
  syn region  yaplHereDoc  matchgroup=Delimiter start="\(<<<\)\@<=\z(\(\I\i*\)\=\(javascript\)\c\(\i*\)\)$" end="^\z1\(;\=$\)\@="  contained contains=@htmlJavascript,yaplIdentifierSimply,yaplIdentifier,yaplIdentifierComplex,yaplSpecialChar,yaplMethodsVar keepend extend
  syn case ignore
endif

" Parent
if exists("yapl_parent_error_close") || exists("yapl_parent_error_open")
  syn match yaplParent "[{}]"  contained
  syn region  yaplParent matchgroup=Delimiter start="(" end=")"  contained contains=@yaplClInside transparent
  syn region  yaplParent matchgroup=Delimiter start="\[" end="\]"  contained contains=@yaplClInside transparent
  if !exists("yapl_parent_error_close")
    syn match yaplParent "[\])]" contained
  endif
else
  syn match yaplParent "[({[\]})]" contained
endif

syn cluster yaplClConst  contains=yaplFunctions,yaplIdentifier,yaplConditional,yaplRepeat,yaplStatement,yaplOperator,yaplRelation,yaplStringSingle,yaplStringDouble,yaplBacktick,yaplNumber,yaplFloat,yaplKeyword,yaplType,yaplBoolean,yaplStructure,yaplMethodsVar,yaplConstant,yaplCoreConstant
syn cluster yaplClInside contains=@yaplClConst,yaplComment,yaplLabel,yaplParent,yaplParentError,yaplInclude,yaplHereDoc
syn cluster yaplClFunction contains=@yaplClInside,yaplDefine,yaplParentError,yaplStorageClass
syn cluster yaplClTop  contains=@yaplClFunction,yaplFoldFunction

" YAPL Region
syn region yaplRegion  matchgroup=Delimiter start="<@" end="@>" contains=@yaplClTop keepend
syn region yaplRegion  matchgroup=Define start="^[^{};]*{$" matchgroup=Delimiter end="^}" contains=@yaplClTop keepend

" Fold
if exists("yapl_folding") && yapl_folding==1
" match one line constructs here and skip them at folding
  syn keyword yaplSCKeyword  abstract final private protected public static  contained
  syn keyword yaplFCKeyword  function  contained
  syn keyword yaplStorageClass global  contained

  set foldmethod=syntax
  syn region  yaplFoldHtmlInside matchgroup=Delimiter start="@>" end="<@" contained transparent contains=@htmlTop
  syn region  yaplFoldFunction matchgroup=Define start="^function\s\([^};]*$\)\@=" matchgroup=Delimiter end="^}" contains=@yaplClFunction,yaplFoldHtmlInside contained transparent fold extend
elseif exists("yapl_folding") && yapl_folding==2
  syn keyword yaplDefine function  contained
  syn keyword yaplStructure  abstract class interface  contained
  syn keyword yaplStorageClass final global private protected public static  contained

  set foldmethod=syntax
  syn region  yaplFoldHtmlInside matchgroup=Delimiter start="@>" end="<@" contained transparent contains=@htmlTop
  syn region  yaplParent matchgroup=Delimiter start="{" end="}"  contained contains=@yaplClFunction,yaplFoldHtmlInside transparent fold
else
  syn keyword yaplDefine function  contained
  syn keyword yaplStructure  abstract class interface  contained
  syn keyword yaplStorageClass final global private protected public static  contained
endif

" corrected highlighting for an escaped '\$' inside a double-quoted string
syn match yaplSpecialChar  "\\\$"  contained display

" highlight object variables inside strings
syn match yaplMethodsVar ":\h\w*" contained contains=yaplMethods,yaplMemberSelector display containedin=yaplStringDouble

" highlight constant E_STRICT
syntax case match
syntax keyword yaplCoreConstant E_STRICT contained
syntax case ignore

" different syntax highlighting for 'echo', 'print', 'switch', 'die' and 'list' keywords
" to better indicate what they are.
syntax keyword yaplDefine echo print contained
syntax keyword yaplStructure list contained
syntax keyword yaplConditional switch contained
syntax keyword yaplStatement die contained

" Highlighting for __autoload slightly different from line above
syntax keyword yaplSpecialFunction containedin=ALLBUT,yaplComment,yaplStringDouble,yaplStringSingle,yaplIdentifier,yaplMethodsVar
  \ __autoload
highlight link yaplSpecialFunction yaplOperator

" option defaults:
if ! exists('yapl_special_functions')
    let yapl_special_functions = 1
endif
if ! exists('yapl_alt_comparisons')
    let yapl_alt_comparisons = 1
endif
if ! exists('yapl_alt_assignByReference')
    let yapl_alt_assignByReference = 1
endif

if yapl_special_functions
    syntax keyword yaplSpecialFunction containedin=ALLBUT,yaplComment,yaplStringDouble,yaplStringSingle
  \ user_error trigger_error isset unset eval extract compact empty
endif

if yapl_alt_assignByReference
    " special highlighting for '=&' operator
    syntax match yaplAssignByRef /=\s*&/ containedin=ALLBUT,yaplComment,yaplStringDouble,yaplStringSingle
    highlight link yaplAssignByRef Type
endif

if yapl_alt_comparisons
  " highlight comparison operators differently
  syntax match yaplComparison "\v[=!]\=\=?" contained containedin=yaplRegion
  syntax match yaplComparison "\v[=<>-]@<![<>]\=?[<>]@!" contained containedin=yaplRegion

  " highlight the 'instanceof' operator as a comparison operator rather than a structure
  syntax case ignore
  syntax keyword yaplComparison instanceof contained containedin=yaplRegion

  hi link yaplComparison Statement
endif

" ================================================================

" Sync
if yapl_sync_method==-1
  syn sync match yaplRegionSync grouphere yaplRegion "^\s*<@\s*$"
  syn sync match yaplRegionSync grouphere NONE "^\s*@>\s*$"
  syn sync match yaplRegionSync grouphere yaplRegion "function\s.*(.*\$"
  "syn sync match yaplRegionSync grouphere NONE "/\i*>\s*$"
elseif yapl_sync_method>0
  exec "syn sync minlines=" . yapl_sync_method
else
  exec "syn sync fromstart"
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_yapl_syn_inits")
  if version < 508
    let did_yapl_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink   yaplConstant  Constant
  HiLink   yaplCoreConstant  Constant
  HiLink   yaplComment Comment
  HiLink   yaplBoolean Boolean
  HiLink   yaplStorageClass  StorageClass
  HiLink   yaplSCKeyword StorageClass
  HiLink   yaplFCKeyword Define
  HiLink   yaplStructure Structure
  HiLink   yaplStringSingle  String
  HiLink   yaplStringDouble  String
  HiLink   yaplBacktick  String
  HiLink   yaplNumber  Number
  HiLink   yaplFloat Float
  HiLink   yaplMethods Function
  HiLink   yaplFunctions Function
  HiLink   yaplBaselib Function
  HiLink   yaplRepeat  Repeat
  HiLink   yaplConditional Conditional
  HiLink   yaplLabel Label
  HiLink   yaplStatement Statement
  HiLink   yaplKeyword Statement
  HiLink   yaplType  Type
  HiLink   yaplInclude Include
  HiLink   yaplDefine  Define
  HiLink   yaplSpecialChar SpecialChar
  HiLink   yaplParent  Delimiter
  HiLink   yaplIdentifierConst Delimiter
  HiLink   yaplParentError Error
  HiLink   yaplOctalError  Error
  HiLink   yaplTodo  Todo
  HiLink   yaplMemberSelector  Structure
  if exists("yapl_oldStyle")
  hi  yaplIntVar guifg=Red ctermfg=DarkRed
  hi  yaplEnvVar guifg=Red ctermfg=DarkRed
  hi  yaplOperator guifg=SeaGreen ctermfg=DarkGreen
  hi  yaplVarSelector guifg=SeaGreen ctermfg=DarkGreen
  hi  yaplRelation guifg=SeaGreen ctermfg=DarkGreen
  hi  yaplIdentifier guifg=DarkGray ctermfg=Brown
  hi  yaplIdentifierSimply guifg=DarkGray ctermfg=Brown
  else
  HiLink  yaplIntVar Identifier
  HiLink  yaplEnvVar Identifier
  HiLink  yaplOperator Operator
  HiLink  yaplVarSelector  Operator
  HiLink  yaplRelation Operator
  HiLink  yaplIdentifier Identifier
  HiLink  yaplIdentifierSimply Identifier
  endif

  delcommand HiLink
endif

let b:current_syntax = "yapl"

if main_syntax == 'yapl'
  unlet main_syntax
endif

" vim: ts=8 sts=2 sw=2 expandtab

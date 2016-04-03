" Vim syntax file
" Language: YAPLS 
" Author: Emanuele Bovisio - ADB Broadband
" Last Change:  March 25, 2011
"
"
syntax match yaplsName /^.*=/me=e-1
syntax match yaplsValue /=.*$/hs=s+1

highlight link yaplsName Define
highlight link yaplsValue String


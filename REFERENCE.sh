#!/bin/bash
# # 
# # This file reference several important variables and commands for bash

# sh:     -n syntax-check only
#         -v print all content of script before running
#         -x print all commands which have been run
# RANDOM: /dev/random, 0~32767
# declare / typeset: 
#         -a -- define array
#         -i -- define integer
#         -x -- define environmental variable
#         -r -- const variable
#         -p -- list the type of variable
#         +  -- when replace -, cancel an operation
#         e.g. new a variable: declare -i number=$RANDOM*10/32768
# set:    watch all variables
# unset:  cancel variable
# PS1:    configuration for the shown line:
#         using man bash(3) for more details
# export: turning a self-define variable into environmental variable
# read:   standard input:
#         read varName <wait for input>; echo $varName
#         read read -p "Pease enter your name: " -t 30 varName    #input a name in 30s
# sort:   -f -- take 'a' and 'A' as the same
#         -b -- ignore space at the beginning
#         -M -- using month names as the sequential names
#         -n -- using numbers as the sequential names
#         -t -- define partition sign e.g. -t ':'
#         -k -- using a certain field to sort e.g. -k 3
# uniq:   same lines only output once
# wc:     word count e.g. wc -w (counting english words)
#                         wc -l (counting how many lines)
# cut:    e.g. cut -d ':' -f 3  # take ':' as partition sign, and take out the 5th field
# grep:   grep 'string'                      -- get lines with keyword 'string'
#         grep -v 'string'                   -- get lines without keyword 'string'
#         grep 'string' <file>               -- from <file>, get those lines with keyword 'string'
#         grep --color=auto 'string' <file>  -- the same as the above one, AND highlight the keyword
# tee:    output as stdout, at the same time save a copy to <file>
#         e.g. last | tee last.list     # output info and replace info of file last.list
#              last | tee -a last.list  # output info and add to the end of file last.list
# tr:     delete or replace given info
#         e.g. last | tr [a-z] [A-Z]
#              last | tr -d ':'         # delete all ':'
# join:   -t
#         -i -- take 'a' and 'A' as the same
#         -1 -- the 1st file should be analyzed by the given field
#         -2 -- the 2nd file should be analyzed by the given field
#         e.g. join -t ':' <file1> <file2>
#              join -t ':' -1 4 <file1> -2 3 <file2>
# paste:  paste two lines together, partitioned by [tab]
# expand: expand -t 6 <file>  # turn [tab] into 6 spaces
# source: read environmental variable configuration profile
# test:   test files or directories' character
#         -efdL              -- isExist, isFile, isDirectory, isLinkfile
#         -rwxs              -- isReadable, isWritable, isExecutable, isNotEmpty
#         -nt                -- is file1 is later than file2 (e.g. test file1 -nt file2)
#         -ef                -- is two files point to the same inode (e.g. file1 -ef file2)
#         -eq/ne/gt/lt/ge/le -- "test int1 <-eq> int2", equal, notEqual, greaterThan, lessThan, gt&equal, lt&equal
#         -z/n               -- is string NULL, is string not NULL
#         -a                 -- AND
#         -o                 -- OR
# seq:    print sequence of numbers
#         e.g. seq n1 n2       -- xrange(n1,n2) in python, except that n1 can be < n2
#              seq -w n1 s n2  -- =n1:s:n2 in Matlab

# Priority of executing commands:
#          ` absolute/com directory of commands (eg. /bin/ls, ./ls)
#          ` using alias definition to find the command
#          ` bash builtin
#          ` $PATH consequetively find the first same command

######################
# KEYWORDS IN SCRIPT
# 
# $#:                 total parameter number
# $<n>:               the n-th parameter n = 0,1,2,...
# $@:                 list all parameter
# &&:                 if the lhs command works, start the rhs command
# ||:                 if the rhs command does not work, start the rhs command
# []:                 each field is to be separated by space, variables in "", const nums in ''
#
# if[]; then          if() {
# elif[]; then        else if() {
# else                else
# fi                  }
#
# case $<varName> in  switch <varName>
#      <content1>)    case <content1>: {
#      <code1>
#      ;;             }
#      <content2>)    case <content2>: {
#      <code2>
#      ;;             }
# esac
# 
# function fncName(){
# }
#
# while[]             while()
# do                  {
# done                }
#
## python-like for loop:
# for <v> in con1,..  var in xrange{}
# do                  {
# done                }
# 
## c-like for loop:
# for((i; lim; stp))  for( ; ; )
# do                  {
# done                }

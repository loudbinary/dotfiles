#!/usr/bin/env bash

# for test
# command -v log_debug &>/dev/null || { . log4bash.sh; log_level DEBUG; }

# Use this function to accept the docs
bashdoc(){
	# https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html
	[ "$BASH_DOC_CAT" == "" ] || {
		# printf '%s - %s - %s\n' "${FUNCNAME[@]}" "${BASH_SOURCE[@]}" "${BASH_LINENO[@]}"
		echo "<!-- ${FUNCNAME[-2]}(${BASH_SOURCE[-2]}:${BASH_LINENO[-3]}) -->"
		cat
		echo
	}
}

# 检测系统
osis()
{
	local n=0
	if [[ "$1" = "-n" ]]; then n=1;shift; fi

    # echo $OS|grep $1 -i >/dev/null
    uname -s |grep -i "$1" >/dev/null

	return $(( $n ^ $? ))
}

# 检测 term
termis()
{
	local n=0
	if [[ "$1" = "-n" ]]; then n=1;shift; fi

    echo $TERM |grep $1 -i >/dev/null

    return $(( $n ^ $? ))
}

# Command exists
iscmd()
{
	local n=0
	if [[ "$1" = "-n" ]]; then n=1;shift; fi

    command -v $1 > /dev/null

    return $(( $n ^ $? ))
}

# 判断元素是否在数组中
iscontains ()
{
	local n=0
	if [[ "$1" = "-n" ]]; then n=1;shift; fi

    local e
    for e in "${@:2}"; do [[ "$e" == "$1" ]] && return $(( $n ^ 0 )); done

    return $(( $n ^ 1 ))
}

# 尝试将给定路径添加到 PATH 中
try_prepend_path()
{
	for p in "$@"
	do
		(echo $PATH | grep "$p:" > /dev/null ) &&
			log_debug Ignore prepand \'$p\',alread in PATH ||
			{ log_info Prepand path \'$p\' ;export PATH="$p:$PATH"; }
	done
}

# 尝试将给定路径添加到 MANPATH 中
try_prepend_manpath()
{
	for p in "$@"
	do
		(echo "$MANPATH" | grep "$p:" > /dev/null ) &&
			log_debug Ignore prepand \'$p\',alread in MANPATH ||
			{ log_info Prepand manpath \'$p\' ;export MANPATH="$p:$MANPATH"; }
	done
}

try_source()
{
	if [ -f "$1" ]; then
		log_debug Source "$1"
		. "$1"
		return 0
	fi
	log_debug Source failed, "$1" not a file
	return 1
}

# Detect have this formula
isbrewed()
{
	iscmd brew || return 1
	brew --prefix $1 1>/dev/null 2>/dev/null
}


bashdoc <<'DOC-HERE'
## utils.sh
工具类定义

### Commands

Command | Arguments | Description | e.g.
----|----|----|----
bashdoc | | 用于接收脚本中的文档 | `bashdoc <<<'#Title Here'`
osis| -n |判断操作系统 | `osis cygwin`, `osis -n linux`
termis| -n | 判断 term 类型 | `termis xterm`
iscmd | -n | 判断是否为可执行命令 | `iscmd git`,`iscmd -n brew`
iscontains | -n | 判断数组是否包含指定元素
isbrewed | | 判断给定的 formula 是否被安装 | `isbrewed go`
try_prepend_path | | 如果给定路径不在 PATH 中,则添加 | `try_prepend_path ~/bin`
try_prepend_manpath | | 如果给定路径不在  MANPATH 中,则添加 | `try_prepend_path ~/man`
try_source | | 尝试 source 文件 | `try_source ~/my-bash`

* `-n` for negative

### Examples
```
iscmd cls || alias cls="echo -en '\ec'"
iscmd -n clear &&  alias clear="cls"

osis Cygwin && {
	# Cygwin stuff
}
osis Linux && {
	# Linux stuff
}
osis Darwin && {
	# Mac OS X stuff
}

	bashdoc <<'DOC-HERE'
	# Markdown title

	What dose `this` mean.
	DOC-HERE

# Generate docs
BASH_DOC_CAT=1 lrc
```
DOC-HERE

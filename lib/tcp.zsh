# shellcheck shell=bash
######################################################################
#<
#
# Function: stream  = p6_shell_tcp_is(port)
#
#  Args:
#	port -
#
#  Returns:
#	stream - 
#
#>
######################################################################
p6_shell_tcp_is() {
  local port="$1"

  lsof -iTCP:"$port" -sTCP:LISTEN -n -P

  p6_return_stream
}

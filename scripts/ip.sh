#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh

main()
{
  cpu_label=$(get_tmux_option "@dracula-ip-addr-label" "IP")
  echo "$cpu_label `curl https://ipinfo.io/ip` "
}

main

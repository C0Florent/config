#!/usr/bin/env nu

export def main [
        pid # PID of the process to stop/resume
] {
        let state = open $"/proc/($pid)/status"
                | find 'State:' -n
                | first
                | str substring 7..7 # "State: " is 7 chars long

        # state "T" means process is stopped
        if $state == "T" {
                kill -s 18 $pid # 18 is SIGCONT
        } else {
                kill -s 19 $pid # 19 is SIGSTOP
        }
}

#!/bin/bash
function screenconfig {
    xrandr | grep '\sconnected' | sed -e 's/connected\([^+]*\).*/\1/g' | sed -e 's/\sprimary\s//g' | xargs | sed -e 's/\s/-/g'
}

echo $(screenconfig);


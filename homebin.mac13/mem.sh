#!/bin/bash
ps -A -o rss,vsz|sed '1d' | awk '{r+=$1;v+=$2}END{print r/1024"k",v/1024"k",r/v}'

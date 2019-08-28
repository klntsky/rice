#!/usr/bin/env bash
free -b | grep Mem | awk '{ printf("%.0f\n", $3 * 100 / $2) }';

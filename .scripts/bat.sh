#!/usr/bin/env sh

acpi | sed 's/Battery 0: //' | sed 's/Unknown, //' | sed 's/Discharging, //' | sed 's/ remaining//'

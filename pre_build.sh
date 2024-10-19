#!/bin/sh

cp ./.config ./TKernelConfig/stm32mp157d_dk1_taris

dt=$(date '+%d/%m/%Y %H:%M:%S');

git commit -a -m "${dt} build."
git push


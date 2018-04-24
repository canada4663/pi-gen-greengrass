#!/bin/sh

adduser --disabled-password -q --gecos "" ggc_core
addgroup ggc_group
adduser ggc_core ggc_group

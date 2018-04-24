#!/bin/sh

adduser --disabled-password -q --gecos "" ggc_user
addgroup ggc_group
adduser ggc_user ggc_group

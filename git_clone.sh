#!/usr/bin/bash

sudo rm -rf $APPLICATION_MAIN_DIR/*
sudo git clone -b $BRANCH $SSH_URL $APPLICATION_MAIN_DIR

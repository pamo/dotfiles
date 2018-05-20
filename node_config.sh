#!/usr/bin/env bash
LTS=9.11.1
nodenv install $LTS
nodenv global $LTS
nodenv rehash

echo "Installing npm updates"
npm install -g npm-check
npm install -g npm-check-updates

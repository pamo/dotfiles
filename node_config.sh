#!/usr/bin/env bash
LTS=6.9.1
nodenv install $LTS
nodenv global $LTS
nodenv rehash

echo "Installing npm updates"
npm install -g npm-check
npm install -g npm-check-updates

echo "Installing yarn"
npm install -g yarn

echo "Installing yarn"
yarn global add gist-cli

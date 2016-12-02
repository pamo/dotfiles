#!/usr/bin/env bash
LTS=6.9.1
nodenv install $LTS
nodenv global $LTS
nodenv rehash

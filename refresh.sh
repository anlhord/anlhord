#!/bin/bash

rm *
rm -rf about  categories  css   images  js   post  tags
git checkout LICENSE
git checkout refresh.sh
chmod +x refresh.sh


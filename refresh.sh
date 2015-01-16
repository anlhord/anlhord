#!/bin/bash

rm *
rm -rf about  categories  css   images  js   post  tags
git checkout LICENSE
git checkout refresh.sh
git checkout CNAME
chmod +x refresh.sh


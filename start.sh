#!/bin/bash
# 
# Author: alex
# Created Time: 2019年03月26日 星期二 15时13分07秒
docker run --rm -ti --runtime=nvidia --name centerface \
    -v `pwd`:/centerface \
    -w /centerface \
    centerface \
    /bin/bash

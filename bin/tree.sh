#!/bin/bash
find . -print | sed -e 's;[^/]*/;|--;g;s;--|; |;g'
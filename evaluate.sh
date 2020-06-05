#!/bin/bash
echo "simple siege"
siege -c1 -t1M http://192.168.99.100:32380
siege -c10 -t1M http://192.168.99.100:32380
siege -c20 -t1M http://192.168.99.100:32380
siege -c30 -t1M http://192.168.99.100:32380
siege -c40 -t1M http://192.168.99.100:32380
siege -c50 -t1M http://192.168.99.100:32380
siege -c100 -t1M http://192.168.99.100:32380


echo "do work siege"
siege -c1 -t1M http://192.168.99.100:32380/do-work 
siege -c10 -t1M http://192.168.99.100:32380/do-work
siege -c20 -t1M http://192.168.99.100:32380/do-work
siege -c30 -t1M http://192.168.99.100:32380/do-work
siege -c40 -t1M http://192.168.99.100:32380/do-work
siege -c50 -t1M http://192.168.99.100:32380/do-work
siege -c100 -t1M http://192.168.99.100:32380/do-work

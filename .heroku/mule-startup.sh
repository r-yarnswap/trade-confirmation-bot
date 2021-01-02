#!/bin/bash
RUNTIME_DOWNLOAD=https://repository-master.mulesoft.org/nexus/service/local/repositories/releases/content/org/mule/distributions/mule-standalone/4.2.0-hf1/mule-standalone-4.2.0-hf1.zip
RUNTIME_FOLDER=mule-standalone-4.2.0-hf1

curl $RUNTIME_DOWNLOAD --output mule.zip

unzip -o mule.zip

rm -rf mule.zip

mv -f target/*.jar $RUNTIME_FOLDER/apps

./$RUNTIME_FOLDER/bin/mule
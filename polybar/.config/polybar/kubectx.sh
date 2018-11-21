#!/bin/bash

WHITE="%{F#FFF}"
UNSET="%{F- B- -o}"

echo -n "${WHITE} $(kubectl config current-context) ${UNSET}"

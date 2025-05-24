#!/usr/bin/env bash
set -ex

dot -Tpdf <(pactree -g $1) | okular -


#!/bin/bash

function git_init() {
    git init && \
        git commit --allow-empty -m "Initial commit" && \
        git add . && \
        git commit -a
}

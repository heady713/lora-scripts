#!/bin/bash

export HF_HOME=huggingface
export PYTHONUTF8=1

uvicorn mikazuki.app:app --host "0.0.0.0" --port 28000

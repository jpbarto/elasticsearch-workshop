#!/bin/sh
pip install -t . -r requirements.txt
zip -r ../dist/lambda_function.zip *

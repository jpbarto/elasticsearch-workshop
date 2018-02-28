p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; font: 12.0px Helvetica}
p.p2 {margin: 0.0px 0.0px 0.0px 0.0px; font: 12.0px Helvetica; min-height: 14.0px}
p.p3 {margin: 0.0px 0.0px 0.0px 0.0px; font: 12.0px 'Courier New'}
p.p4 {margin: 0.0px 0.0px 0.0px 0.0px; font: 12.0px 'Courier New'; min-height: 14.0px}

**Lab 3 “API Gateway, Lambda, ElasticSearch”**

**1 - Go to Lambda in the AWS Console**

Click on “Create function”

Select “Author from scratch”

Give your function a name, i.e. “imageIndexQuery”

Select Python 2.7 as the runtime

Select “Use existing role”

Use the previously created role

Click on “Create function”

Once complete, in the “Function code” section, under “Code entry type” click the drop-down menu and select ‘Upload a .ZIP file’

(Browse to the GitHub repo and download code.zip to your computer)

Select the code.zip file and then click save on the lambda function menu (top right)

Once this is complete and you can see the code in the lambda_function code editor page, we have to enter your Elastic Search domain’s endpoint

Replace the code in lambda_function with:

——————
```python

from __future__ import print_function

from pprint import pprint

import boto3

import json

from elasticsearch import Elasticsearch, RequestsHttpConnection

import urllib

import json

print('Loading function')

def connectES(esEndPoint):

    print ('Connecting to the ES Endpoint {0}'.format(esEndPoint))

    try:

        esClient = Elasticsearch(

            hosts=[{'host': esEndPoint, 'port': 443}],

            use_ssl=True,

            verify_certs=True,

            connection_class=RequestsHttpConnection)

        return esClient

    except Exception as E:

        print("Unable to connect to {0}".format(esEndPoint))

        print(E)

        exit(3)

def lambda_handler(event, context):

    print("Received event: " + json.dumps(event, indent=2))

    esClient = connectES(“&lt;your endpoint&gt;“)

    content = esClient.search(index='metadata-store')

    return {

       "statusCode" : 200,

       "body": json.dumps({'input': event,'results': content})

};
```

——————

Save the function again.

**2 - Go to API Gateway in the AWS Console**

Click on “Create API”

Select “New API”

Type a name for the API

Select “Regional” in the Endpoint Type drop down menu.

Click on Create API

Once the API has been created, you’ll go to the Resources view.

Select the root resource, click on Actions

Select “Create Method” 

Select “POST”

In the Setup section:

Leave “Integration type” as Lambda Function

Check the box for “Use Lambda Proxy integration”

Select “eu-west-1”  in the Lambda region drop down menu

In the Lambda Function textbook, type the name of the lambda function we created above and select it.

Click Save and then OK on the popup window

Go ahead and test the function
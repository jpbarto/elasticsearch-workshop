p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; font: 12.0px Helvetica}
p.p2 {margin: 0.0px 0.0px 0.0px 0.0px; font: 12.0px Helvetica; min-height: 14.0px}
p.p3 {margin: 0.0px 0.0px 0.0px 0.0px; font: 11.0px Menlo; color: #000000}
span.s1 {font-variant-ligatures: no-common-ligatures; background-color: #ffffff}

**Lab 2 “S3, Lambda, ElasticSearch”**

**1 - Go to “Elastic Search” in the AWS Console**

Click on “Create a new domain”

Type a domain name: i.e. “gslabs3”

Select ElasticSearch version as “2.3”

Click “Next”

Set Instance count as “2”

Set Instance type as “t2.medium.elastisearch”

In the storage section set EBS Volume Size as “30” GB and leave the rest of the options as default

Click “Next”

In the Network Configuration section, select Public Access

In the Access Policy select the “Allow open access to the domain” - !! WARNING !! This is not recommended for production

Click Next, then

Click Confirm to start the cluster creation

(This can take up to 20 minutes, so please go to the next step)

**2 - Go to S3 in the AWS Console**

Click on “Create bucket”

Enter a unique name for the bucket, i.e. gslabs3-$username

Select region as “EU Ireland”

Click on “Create”

**3 - Go to Lambda in the AWS Console**

Click on “Create function”

Select “Author from scratch”

Give your function a name, i.e. “imageIndexBuilder”

Select Python 2.7 as the runtime

Select “Create new role from template”

Type a name for your role, i.e. “lambda_s3_read_access”

In the Policy templates select “S3 object read-only permissions”

Click on “Create function”

Once complete, in the “Function code” section, under “Code entry type” click the drop-down menu and select ‘Upload a .ZIP file’

(Browse to the GitHub repo and download code.zip to your computer)

Select the code.zip file and then click save on the lambda function menu (top right)

Once this is complete and you can see the code in the lambda_function code editor page, we have to enter your Elastic Search domain’s endpoint

Find the line where we make a connection to the endpoint: esClient = connectES(“ **** “) and replace with your endpoint

Save the function again.

We will now enable S3 events to trigger this lambda function

On the left, under “Add triggers”, click on S3

On the “Configure triggers” section:

Under Bucket select the bucket you created earlier, i.e. “gslabs3-$username”

Under Event type, select “Object Created (All)”

Click Add on the bottom right to complete this step.

**At this point, we have configured ElasticSearch, S3, and Lambda.**

Go back to S3 in the AWS Console.

Click on the bucket you created earlier

Upload your images

Once finished, then you can query the ES index:

curl -XGET https://search-gslab-3rkqcvlwngfjjvq4ldckzi3upm.eu-west-1.es.amazonaws.com/metadata-store/images/_search?pretty



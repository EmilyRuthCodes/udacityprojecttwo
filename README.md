# CD12352 - Infrastructure as Code Project Solution
# Emily Cutler-Ames
URL - http://udacit-loadb-26bpqnbys2im-2051418031.us-east-1.elb.amazonaws.com/

## Spin up instructions
Check your AWS account is set up in the command line by running the following commands
aws configure list
aws iam list-users 

First you will need to create the s3 bucket using 

./run.sh build

Once created you will need to manually upload the index.html file to the S3 bucket, this is easiest to do in the AWS GUI. 

Then to spin up both stacks run

./run.sh create

## Tear down instructions
If you want to delete the stacks, first you will need to empty the S3 bucket then delete, this is easiest to do in the GUI. 

Then to delete the remaining stacks run

./run.sh delete

## Other considerations
Once created if you want to make changes to either the udagram or networks stack you may do so and then update them using

./run.sh update


## Additional notes 

Based on feedback from my most recent review I asked a mentor this question and got the following response:
Question: Finally, instructions say to spin up and tear down via scripts but I don't understand how this can be achieved if there is manual work to do half way through?

I agree with you on this one.

You'll be able to delete the udagram and network stacks using scripts, but to delete S3 stack, you'll have to first empty the S3 bucket.
Once again, you can always re-submit and mention the same in the project review as I know some reviewers strictly follow the project rubric to evaluate this point, while some reviewers evaluate it in a practical sense and ask students to download the webpage via S3

Therefore, I have created an additional s3.yml file to create the bucket and the content needs adding manually. I have been directed on this approach my a udacity mentor so assume it is correct and the assignement will pass. 



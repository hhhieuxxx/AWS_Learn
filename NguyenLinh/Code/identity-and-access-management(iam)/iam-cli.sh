# check version
aws --version

# config access-key
aws configure

#Test credential
aws sts get-caller-identity

#List all s3 bucket
aws s3 ls

#Download file
aws s3 cp <s3://path/file_name> <local destination>

#Upload file
aws s3 cp <local destination> <s3://path/>
aws s3 cp <local destination> <s3://path/> --recursive
aws s3 cp .\ecommerce-website-html-css-master\ s3://my-bucker-20240527 --recursive --profile admin

#Lisst file
aws s3 ls <s3://path>

# remove file
aws s3 rm <s3://path//file_name>

#Using cli with MFA
#Step 1 issue temporary token
aws sts get-session-token --serial-number <arn_mfa_device> --token-code <code> 

#Step 2: config credential file.
"C:\Users\<your user name>\.aws\credentials"
#--------------------
[admin]
aws_access_key_id = ASIA262LATS2LMWKY4WG
aws_secret_access_key = do8C/EtCHAlbulWYDc3SU1fVywbhG7MRJmaTQTAn
aws_session_token = IQoJb3JpZ2luX2VjEEgaDmFwLXNvdXRoZWFzdC0xIkcwRQIhAOA60GTg0r27llZ3puuKrdoU3GtQJOp309apxG27OTiHAiB8xY8XlaGkKvOzSxrhjYmIyJvVPDpcO41ap2ozi2X/eir4AQjB//////////8BEAAaDDc1MzM4NzIxNjA1MiIMeoxjObjXhLsXWVSYKswBMcPRO8dhpYI4w1RxN2HBhYTBT0xgD+1CPlpaOFV8rcrhGM5+ztnF6cD7j1vnZx5ALOTBR8ekj6ed/6M1PSl0AVM/CZtvppl1VgqWruFbrbd+xy1XbC7mtHCIWubomF5+NmQVEKG5cdox34vAPiC56/fR6gXz6iz0hLPZ84xdi4AsGZnwx86S93djS14CHiZo5bTaKwsZJDLDkVQrcrafV/N8RSiqX6e0+537s+u/Xqv/qmBc+ag1uivDvcBM/2E76Uh4Jf/JONM+hqrgMI+8zbIGOpgBYrXkOnXM9PkTTVvTemWhc5vM8F94gI0ucR4ntz7f4yNp/H/I8B1Ui+gl44TAW0jvzfEGwV5HFdYEH/nURJ1QPmfASb8VSiYk74xKMX5vMzCq5DJgsmSoTbkW+v/Yl1oVFxH3l3SuF4NcLzM6leAo/5fsrYiVA4enfF+BvwcUhseMR/1a+jLK8M8u5KMcQe1TE3CID06i9rc=
#-------------

#Step 3: specify --profile when run command.
aws s3 ls --profile admin
aws s3 ls s3://<your-bucket-name>/ --profile admin
aws s3 ls s3://my-bucket-20240526/ --profile admin

# how to do not use accesskey to connect to s3
# standard way is using role

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 753387216052.dkr.ecr.us-east-1.amazonaws.com






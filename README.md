# AutoStartStopRDS
Start and Stop of RDS Databases using Lambda and CloudWatch Events

Invoke Lambda to start/stop RDS instances:
aws lambda invoke --function-name rds-lambda-stop-start --payload '{ "instances": [ "rds_instance_1", "rds_instance_2"], "action":"action_name" }' output

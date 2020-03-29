# Change
export COGNITO_AUTH_DOMAIN=auth.devopstar.com

export AWS_REGION=us-west-2
export AWS_CLUSTER_NAME=eks-kubeflow
export AWS_COGNITO_STACK_NAME=eks-kubeflow-cognito

export COGNITO_USER_POOL=$(aws cloudformation describe-stacks --stack-name $AWS_COGNITO_STACK_NAME \
                --region $AWS_REGION \
                --query 'Stacks[0].Outputs[?OutputKey==`UserPool`].OutputValue' \
                --output text)
export COGNITO_CLIENT_APP_ID=$(aws cloudformation describe-stacks --stack-name $AWS_COGNITO_STACK_NAME \
                --region $AWS_REGION \
                --query 'Stacks[0].Outputs[?OutputKey==`UserPoolClientId`].OutputValue' \
                --output text)
export AWS_CLUSTER_NODE_ROLE=$(aws eks describe-nodegroup --nodegroup-name nodegroup \
                --region $AWS_REGION \
                --cluster-name $AWS_CLUSTER_NAME \
                --query 'nodegroup.nodeRole')

export BASE_DIR=${PWD}
export KF_NAME=${AWS_CLUSTER_NAME}
export KF_DIR=${BASE_DIR}/${KF_NAME}

export CONFIG_URI="https://raw.githubusercontent.com/kubeflow/manifests/v1.0-branch/kfdef/kfctl_aws_cognito.v1.0.1.yaml"
export CONFIG_FILE=${KF_DIR}/kfctl_aws.yaml
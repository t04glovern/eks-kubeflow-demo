export AWS_REGION=us-west-2
export AWS_CLUSTER_NAME=eks-kubeflow
export KF_NAME=${AWS_CLUSTER_NAME}

export BASE_DIR=${PWD}
export KF_DIR=${BASE_DIR}/${KF_NAME}

export CONFIG_URI="https://raw.githubusercontent.com/kubeflow/manifests/v1.0-branch/kfdef/kfctl_aws.v1.0.1.yaml"
export CONFIG_FILE=${KF_DIR}/kfctl_aws.yaml
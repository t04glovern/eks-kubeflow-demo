# EKS Kubeflow Demo

## Requirments

* [AWS CLI Setup](https://aws.amazon.com/cli/) and configured
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
    ```bash
    $ sudo curl --silent --location -o /usr/local/bin/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl
    $ sudo chmod +x /usr/local/bin/kubectl
    ```
* [aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
    ```bash
    $ sudo curl --silent --location -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator
    $ sudo chmod +x /usr/local/bin/aws-iam-authenticator
    ```
* [eksctl](https://eksctl.io/introduction/installation/)
    ```bash
    $ curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    $ sudo mv -v /tmp/eksctl /usr/local/bin
    ```
* [kfctl](https://github.com/kubeflow/kfctl)
    ```bash
    $ curl --silent --location "https://github.com/kubeflow/kfctl/releases/download/v1.0.1/kfctl_v1.0.1-0-gf3edb9b_linux.tar.gz" | tar xz -C /tmp
    $ sudo mv -v /tmp/kfctl /usr/local/bin
    ```

## EKS Setup

Create new EKS cluster using the eks config file in the demo repository

```bash
eksctl create cluster -f eks-kubeflow-cluster.yaml
```

## Kubeflow

### Setup

```bash
source ./eks-kubeflow-install.sh

# Create the Kubeflow setup directory
mkdir -p ${KF_DIR} && cd ${KF_DIR}

# Download the config file
wget -O kfctl_aws.yaml $CONFIG_URI

# Replace existing info with your setup
sed -i '/region: us-west-2/ a \      enablePodIamPolicy: true' ${CONFIG_FILE}
sed -i -e 's/kubeflow-aws/'"$AWS_CLUSTER_NAME"'/' ${CONFIG_FILE}
sed -i "s@us-west-2@$AWS_REGION@" ${CONFIG_FILE}

# Disable IAM roles
sed -i "s@roles:@#roles:@" ${CONFIG_FILE}
sed -i "s@- eksctl-$AWS_CLUSTER_NAME-nodegroup-ng-a2-NodeInstanceRole-xxxxxxx@#- eksctl-$AWS_CLUSTER_NAME-nodegroup-ng-a2-NodeInstanceRole-xxxxxxx@" ${CONFIG_FILE}
```

### Deploy

```bash
cd ${KF_DIR}
kfctl apply -V -f ${CONFIG_FILE}
```

Check the cluster status using the following

```bash
kubectl -n kubeflow get all
```

### Get Started

Retrieve the endpoint for Kubeflow using the following

```bash
kubectl get ingress -n istio-system -o jsonpath='{.items[0].status.loadBalancer.ingress[0].hostname}'
# 82aa8b05-istiosystem-istio-2af2-1293882277.us-west-2.elb.amazonaws.com
```

![Setup Kubeflow](img/kubeflow-get-started-01.png)

Create the namespace `ekskubeflow`.

![Setup Kubeflow Namespace](img/kubeflow-get-started-02.png)

Create a new Notebook

![Kubeflow Notebook](img/kubeflow-notebook-create.png)

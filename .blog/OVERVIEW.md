# Kubeflow

Making deployments of Machine Learning workflows simple, portable and scalable on Kubernetes (EKS in this example)

## Pros

* Standard Custom Resource Definition (CRD), so it aligns with the direction Kubernetes is heading.
* Self-service notebooks, training jobs, inference endpoints without needing to understand frameworks like CDK/CFN/Terraform.
  * Particularly cool for GPU allocation
* Kubeflow Pipelines SDK can be used to orchestrate SageMaker & EMR resources automatically behind the scenes; and abstract all this for data scientists
* Cognito Authentication for the dashboard is supported and well documented.
* Public or Private deployments of Kubeflow are supported and well documented.
* Multi-cloud (lol...)
  * GCP, Azure, IBM and OpenShift inter operable
* Deployment defined using kfctl (Kubeflow CLI) and eksctl.
  * So majority of the deployment can be scripted and version controlled.
* Support for Katib (system for Hyperparameter Tuning and Neural Architecture Search) with decent looking visual tools. 
  * This would Parity SageMaker Studio model debugger
* Good workshops and examples provided by AWS
  * https://github.com/aws-samples/eks-kubeflow-workshop/tree/master/notebooks

## Cons

* Operational overhead of needing to know a bit of Kubernetes to manage the underlying deployments.
* Not fully managed service like SageMaker Studio is trying to be.
* Kubeflow is new (but version 1.0 did just launch)
* Upgrade path is documented however I'm sure there's dragons
* Actual end to end CI/CD for pipelines as code with Kubeflow is still early days
  * There is a Kubeflow Tekton repository, so it's on the horizon (https://github.com/kubeflow/kfp-tekton)
* Kubernetes isn't opinionated which can be a pain sometimes, a lot of support is half baked because they can rely on the user coming up with ways to solve engineering problems.

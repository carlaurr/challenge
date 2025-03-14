# Security

## Introduction

The core idea of a Zero Trust architecture is to never trust and always verify. Every requests should be authenticated and autorized, even if it's internal. This is the main principle that it's folowed in this security design proposal.

## Zero Trust Architecture

### Requests
Incoming requests to the Golang server should be authenticated (using JWT tokens, for example) and authorized. The server should validate who is making the requests and if they have the right permissions to access the resources or make a certain action.

If in the future more services are added to the architecture, the internal communications between them should alse be protected using a service-to-service authentication and authorizations mechanism.  
We can use a service mesh such as Istio or Linkerd to implement mTLS, encrypting the inter-service traffic and verifying that only the allowed services can communicate with each other. This way, we are not assuming implicit trust inside the network, preventing attacks in case one of the services is compromised.

### RBAC in Kubernetes
Role-based access control is used in Kubernetes to prevent that unhautorized users or service accounts can access the resources in the cluster. We should define roles and role bindings to grant the minimum permissions required to perform the actions needed.

For example, RBAC policies can be defined to allow the Golang server to read and write to the pods logs, but not to delete them. This way, we are following the principle of least privilege, granting only the permissions needed to perform the actions required.

The same applies to users that access the Kubernetes cluster. The infrastructure team should have the necessary permissions to manage the cluster, while the developers should have only read access or access to the namespaces where they deploy their applications.

### Use Pod Security Admission (PSA)
PSA define [standards][psa-standards], at cluster and namespace level, for the security of the pods running in the cluster. In our case, the namespace where the Golang server is deployed can have a baseline isolation level as these resources don't require high privileges.

### Define Resources Policies
Kyverno is complementary to PSA and allows us to configure more granular and customizable policy enforments. For example, we can define a policy to ensure that pods run as non-root users and have the minimal privileges required to perform their actions while adding some exceptions for some pods that need more privileges.

### Access Control

We should not forget about users permissions and access control to ArgoCD, ArgoRollouts, GitHub or any other tool used in the cycle of the application. These are the basic security measures to take into account:

- Use RBAC to define roles and permissions when possible. In ArgoCD only admins should be able to access internal configurations while developers have read access or the minimum permissions to deploy or rollback their applications. In GitHub, changes should be reviewed and approved by owners and teams should have the minimim permissions in repositories that they don't own.
- Always enforce 2FA for all the tools that support it.


## Secrets

Secrets should be stored in a secure way, using solutions like HashiCorp Vault or GCP Secret Manager.  
If we opt for Vault, it can be integrated with Kubernete and pods can retrieve the secrets at runtime.  

Vault also allows to define dynamic secrets that reduce the risk of accidental leakes apart of facilitate the rotation of the secrets.

## Web Application Firewall

Traffic comming from the internet into the our infrastructure should always pass through a Web Application Firewall (WAF), like GCP Cloud Armor or Cloudflare. A Firewall will help to protect against DDoS attacks and other common vulnerabilities.
Between all the configurations that can be done in a WAF, the most important are:

- Filter out malicious traffic at the load balancer level. WAF can detect SQL injections attacks and common strategies used by attackers to exploit vulnerabilities and block them before reaching our internal services.
- Rate limiting to prevent DDoS attacks. GeoIP blocking is also useful in this case to block traffic from countries from where we don't expect traffic.

## Audit Logging

In architecture proposed in this challenge is composed by different components and tools (GCP, Kubernetes, GitHub, ArgoCD, ArgoRollouts and the applications deploted by us). It's important to have audit logs enabled in all of them to trach all the actions performed by users and services. If a malicious actor gains access to one of the tools, the audit logs will help us to detect the intrusion and take actions to mitigate the impact.

Having all the logs scattered in different places can be a mess and dificult the analysis of them in case of an incident. In our case, it would be recommended to centralize all the logs in a single place, such as Loki or Google Cloud Logging. ArgoCD, kuberenetes and GitHub audit logs can be ingested in any of these solutions.

[psa-standards]: https://kubernetes.io/docs/concepts/security/pod-security-standards/

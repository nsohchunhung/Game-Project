# Appendix A: Glossary of Terms

*Comprehensive definitions of DevOps and Kubernetes terminology*

---

## A

**Application Programming Interface (API)**
A set of protocols and tools for building software applications. In this project, the backend exposes a REST API for the frontend to communicate with.

**ArgoCD**
A declarative GitOps continuous delivery tool for Kubernetes. It monitors Git repositories for changes and automatically syncs applications to match the desired state.

**Autoscaling**
The automatic scaling of computing resources based on demand. Kubernetes Horizontal Pod Autoscaler (HPA) adds or removes pods based on CPU/memory usage.

## B

**Blue-Green Deployment**
A deployment strategy where two identical production environments (blue and green) exist. Traffic switches from one to the other for zero-downtime deployments.

**BuildKit**
Docker's next-generation build system that provides improved performance, better caching, and advanced features for container image builds.

## C

**Canary Deployment**
A deployment strategy where new versions are rolled out to a small subset of users before full deployment, allowing for risk mitigation.

**CI/CD (Continuous Integration/Continuous Deployment)**
Development practices where code changes are automatically tested, built, and deployed through automated pipelines.

**ClusterIP**
A Kubernetes service type that exposes services only within the cluster. This is the default service type for internal communication.

**ConfigMap**
A Kubernetes object used to store non-confidential configuration data in key-value pairs. Pods can consume ConfigMaps as environment variables or mounted files.

**Container**
A lightweight, standalone package that includes everything needed to run an application: code, runtime, system tools, libraries, and settings.

**Container Registry**
A repository for storing and distributing container images. Examples include Docker Hub, GitHub Container Registry, and Amazon ECR.

**CrashLoopBackOff**
A Kubernetes pod status indicating that a container repeatedly fails and restarts. Usually indicates application startup issues or misconfigurations.

## D

**Declarative Configuration**
A method of configuration where you specify the desired end state, and the system figures out how to achieve it. Kubernetes uses declarative YAML manifests.

**Deployment**
A Kubernetes object that manages a set of identical pods, providing declarative updates and rollback capabilities.

**Docker**
A platform for developing, shipping, and running applications using container technology.

**Docker Compose**
A tool for defining and running multi-container Docker applications using YAML configuration files.

**Drift Detection**
The ability to identify differences between the desired configuration (in Git) and the actual running state (in the cluster).

## E

**Endpoint**
A network address (IP and port) where a service can be accessed. Kubernetes automatically manages endpoints for services.

**Environment Variable**
A dynamic value that can affect running processes. Used to configure applications without hardcoding values.

## F

**Finalizer**
A Kubernetes mechanism that prevents object deletion until specific cleanup tasks are completed.

## G

**Git**
A distributed version control system used to track changes in source code and configuration files.

**GitOps**
A way of implementing Continuous Deployment where Git is the single source of truth for declarative infrastructure and applications.

**Grafana**
An open-source platform for monitoring and observability that creates dashboards and graphs from time series data.

## H

**Health Check**
Tests that determine whether an application or service is functioning correctly. Kubernetes uses liveness and readiness probes.

**Helm**
A package manager for Kubernetes that uses charts to define, install, and upgrade applications.

**High Availability (HA)**
System design that ensures operational performance and uptime that satisfies business requirements.

**Horizontal Pod Autoscaler (HPA)**
A Kubernetes controller that automatically scales the number of pods based on CPU utilization or custom metrics.

## I

**Image**
A read-only template used to create containers. Contains application code, runtime, libraries, and dependencies.

**ImagePullPolicy**
A Kubernetes setting that determines when to pull container images: Always, IfNotPresent, or Never.

**Ingress**
A Kubernetes API object that manages external access to services, typically via HTTP/HTTPS with features like load balancing and SSL termination.

**Ingress Controller**
A pod that implements the Ingress API, such as NGINX Ingress Controller or Traefik.

## J

**JSON (JavaScript Object Notation)**
A lightweight data interchange format that's easy for humans to read and write, commonly used for APIs and configuration.

## K

**k3d**
A lightweight wrapper to run k3s (Rancher Lab's minimal Kubernetes distribution) in Docker containers.

**kubectl**
The command-line tool for interacting with Kubernetes clusters.

**Kubernetes (k8s)**
An open-source container orchestration platform for automating deployment, scaling, and management of containerized applications.

**Kustomize**
A tool for customizing Kubernetes configurations without templates, using overlays and patches to modify base manifests.

## L

**Liveness Probe**
A Kubernetes health check that determines if a container is running. Failed liveness probes result in container restarts.

**Load Balancer**
A service that distributes incoming requests across multiple backend servers to ensure no single server is overwhelmed.

## M

**Manifest**
A YAML or JSON file that describes the desired state of Kubernetes objects like pods, services, and deployments.

**Metrics**
Quantitative measurements of system performance, such as CPU usage, memory consumption, or request latency.

**Microservices**
An architectural approach where applications are built as a collection of small, independent services that communicate over APIs.

## N

**Namespace**
A Kubernetes feature that provides a mechanism to divide cluster resources between multiple users or applications.

**Network Policy**
A Kubernetes specification that controls how pods are allowed to communicate with each other and other network endpoints.

**Node**
A worker machine in Kubernetes that runs pods. Can be a virtual or physical machine.

## O

**Observability**
The ability to understand the internal state of a system based on external outputs, typically through metrics, logs, and traces.

**Overlay**
In Kustomize, a layer of configuration that modifies base resources for specific environments or use cases.

## P

**Pod**
The smallest deployable unit in Kubernetes, containing one or more containers that share storage and network.

**PersistentVolume (PV)**
A piece of storage in the cluster that provides persistent storage for applications.

**PersistentVolumeClaim (PVC)**
A request for storage by a user that binds to a PersistentVolume.

**Prometheus**
An open-source monitoring and alerting toolkit designed for reliability and scalability.

**PromQL**
Prometheus Query Language used to query metrics data stored in Prometheus.

## Q

**Quality of Service (QoS)**
Kubernetes classification of pods based on resource requests and limits: Guaranteed, Burstable, or BestEffort.

## R

**Readiness Probe**
A Kubernetes health check that determines if a container is ready to serve traffic. Failed readiness probes remove the pod from service endpoints.

**Replica**
An identical copy of a pod. Deployments manage multiple replicas for high availability and load distribution.

**ReplicaSet**
A Kubernetes controller that ensures a specified number of pod replicas are running at any given time.

**Resource Limit**
The maximum amount of CPU or memory a container can use. Kubernetes enforces these limits.

**Resource Request**
The amount of CPU or memory guaranteed to a container. Used by the Kubernetes scheduler for pod placement.

**Rolling Update**
A deployment strategy that gradually replaces old versions with new ones, ensuring zero downtime.

**Rollback**
The process of reverting to a previous version of an application or configuration.

## S

**Secret**
A Kubernetes object that stores sensitive data such as passwords, tokens, or keys.

**Security Context**
Security settings applied to pods or containers, including user ID, group ID, and capabilities.

**Service**
A Kubernetes abstraction that defines a logical set of pods and a policy for accessing them.

**Service Discovery**
The automatic detection of services and their locations within a network.

**Service Mesh**
An infrastructure layer that handles service-to-service communication, often providing features like load balancing, encryption, and observability.

**StatefulSet**
A Kubernetes controller that manages stateful applications, providing stable network identities and persistent storage.

## T

**Tagging**
The practice of labeling container images with version identifiers, typically including version numbers or commit hashes.

**Taint**
A Kubernetes node property that repels pods unless they have a matching toleration.

**Toleration**
A pod property that allows scheduling on nodes with matching taints.

## U

**Upstream**
In networking contexts, refers to the direction toward the origin server or the servers that provide the actual service.

## V

**Volume**
Storage that is accessible to containers in a pod. Can be temporary (emptyDir) or persistent (PersistentVolume).

## W

**Webhook**
An HTTP callback that occurs when something happens; often used for triggering automation based on events.

**Workload**
A generic term for applications or services running on Kubernetes, including deployments, jobs, and daemon sets.

## Y

**YAML (YAML Ain't Markup Language)**
A human-readable data serialization standard commonly used for configuration files and data exchange.

---

## Common Acronyms

**API** - Application Programming Interface  
**CD** - Continuous Deployment  
**CI** - Continuous Integration  
**CLI** - Command Line Interface  
**CPU** - Central Processing Unit  
**DNS** - Domain Name System  
**HA** - High Availability  
**HPA** - Horizontal Pod Autoscaler  
**HTTP** - Hypertext Transfer Protocol  
**HTTPS** - HTTP Secure  
**IP** - Internet Protocol  
**JSON** - JavaScript Object Notation  
**k8s** - Kubernetes (8 letters between 'k' and 's')  
**LB** - Load Balancer  
**MTTR** - Mean Time To Recovery  
**PV** - PersistentVolume  
**PVC** - PersistentVolumeClaim  
**QoS** - Quality of Service  
**RAM** - Random Access Memory  
**RBAC** - Role-Based Access Control  
**REST** - Representational State Transfer  
**SLI** - Service Level Indicator  
**SLO** - Service Level Objective  
**SRE** - Site Reliability Engineering  
**SSL** - Secure Sockets Layer  
**TCP** - Transmission Control Protocol  
**TLS** - Transport Layer Security  
**TTL** - Time To Live  
**UI** - User Interface  
**URL** - Uniform Resource Locator  
**VPA** - Vertical Pod Autoscaler  
**YAML** - YAML Ain't Markup Language

---

## Context-Specific Terms

### In This Project

**Humor Memory Game**
The sample application used throughout this guide - a web-based memory game with user accounts, leaderboards, and game statistics.

**gameapp.local**
The local domain used for testing the application during development.

**gameapp.games**
The example production domain referenced in configuration examples.

**humor-game namespace**
The Kubernetes namespace where the main application components are deployed.

---

This glossary provides definitions for terms used throughout the guide. For more detailed explanations, refer to the relevant chapters where these concepts are applied in practice.

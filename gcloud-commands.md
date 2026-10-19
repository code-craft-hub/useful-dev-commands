# gcloud Commands Reference

A practical reference for the Google Cloud CLI (`gcloud`), grouped by service.
Anything in `ANGLE_BRACKETS` is a placeholder you replace.

> Tip: append `--help` to any command for full flags, and `--format=json`, `--format="value(field)"`,
> or `--filter="expr"` to almost any `list`/`describe` command.

---

## Table of Contents

- [Install, Update & Version](#install-update--version)
- [Authentication](#authentication)
- [Configuration & Named Configs](#configuration--named-configs)
- [Projects & Organizations](#projects--organizations)
- [Billing](#billing)
- [Services / APIs](#services--apis)
- [IAM & Service Accounts](#iam--service-accounts)
- [Compute Engine (VMs)](#compute-engine-vms)
- [Networking (VPC, Firewall, LB, DNS)](#networking-vpc-firewall-lb-dns)
- [Cloud Storage](#cloud-storage)
- [Cloud Run](#cloud-run)
- [Cloud Functions](#cloud-functions)
- [App Engine](#app-engine)
- [Google Kubernetes Engine (GKE)](#google-kubernetes-engine-gke)
- [Artifact Registry & Container Registry](#artifact-registry--container-registry)
- [Cloud Build](#cloud-build)
- [Cloud SQL](#cloud-sql)
- [Firestore & Datastore](#firestore--datastore)
- [Bigtable & Spanner](#bigtable--spanner)
- [BigQuery (bq)](#bigquery-bq)
- [Pub/Sub](#pubsub)
- [Secret Manager](#secret-manager)
- [KMS (Key Management)](#kms-key-management)
- [Logging](#logging)
- [Monitoring & Error Reporting](#monitoring--error-reporting)
- [Cloud Scheduler & Tasks](#cloud-scheduler--tasks)
- [Workflows & Eventarc](#workflows--eventarc)
- [Composer, Dataflow, Dataproc](#composer-dataflow-dataproc)
- [Vertex AI](#vertex-ai)
- [Resource Manager & Asset Inventory](#resource-manager--asset-inventory)
- [Deployment Manager](#deployment-manager)
- [Formatting, Filtering & Scripting](#formatting-filtering--scripting)
- [Components & Alpha/Beta Tracks](#components--alphabeta-tracks)
- [Troubleshooting](#troubleshooting)
- [Common One-Liner Recipes](#common-one-liner-recipes)

---

## Install, Update & Version

```bash
gcloud version                              # Show installed SDK and component versions
gcloud components list                      # List all installable/installed components
gcloud components update                    # Update all installed components to latest
gcloud components install kubectl           # Install a component (kubectl, gke-gcloud-auth-plugin, alpha, beta)
gcloud components remove kubectl            # Uninstall a component
gcloud components update --version=450.0.0  # Pin the SDK to a specific version
gcloud info                                 # Dump environment: paths, config, account, python version
gcloud info --run-diagnostics               # Run network/auth diagnostics for the installation
gcloud cheat-sheet                          # Print the official gcloud cheat sheet
gcloud feedback                             # Open an issue template pre-filled with environment details
```

---

## Authentication

```bash
gcloud auth login                                    # Browser-based login for the CLI user account
gcloud auth login --no-launch-browser                # Login on a headless machine via copy/paste code
gcloud auth list                                     # List credentialed accounts; * marks the active one
gcloud config set account <EMAIL>                    # Switch the active account
gcloud auth revoke <EMAIL>                           # Remove stored credentials for an account
gcloud auth revoke --all                             # Revoke every stored credential

gcloud auth application-default login                # Create ADC for local apps/SDKs (not for gcloud itself)
gcloud auth application-default print-access-token   # Print a short-lived ADC access token
gcloud auth application-default revoke                          # Remove the local ADC credentials
gcloud auth application-default set-quota-project <PROJECT_ID>  # Set the billing/quota project for ADC

gcloud auth print-access-token                       # OAuth access token for the active account (for curl)
gcloud auth print-identity-token                     # OIDC identity token (for calling Cloud Run / IAP)
gcloud auth print-identity-token --audiences=<URL>   # Identity token scoped to a specific audience

gcloud auth activate-service-account --key-file=key.json    # Authenticate as a service account from a key file
gcloud auth configure-docker                                # Configure Docker to use gcloud as credential helper
gcloud auth configure-docker us-central1-docker.pkg.dev     # Same, for a specific Artifact Registry host
```

---

## Configuration & Named Configs

```bash
gcloud config list                          # Show the active configuration's properties
gcloud config list --all                    # Show every property, including unset sections
gcloud config get-value project             # Read a single property
gcloud config set project <PROJECT_ID>      # Set the default project
gcloud config set compute/region us-central1        # Default region for compute-style commands
gcloud config set compute/zone us-central1-a        # Default zone
gcloud config set run/region us-central1            # Default Cloud Run region
gcloud config set core/disable_prompts true         # Never prompt (same effect as --quiet)
gcloud config unset compute/zone                    # Remove a property

gcloud config configurations list                    # List named configurations (profiles)
gcloud config configurations create <NAME>           # Create and activate a new configuration
gcloud config configurations activate <NAME>         # Switch profiles (project + account + region at once)
gcloud config configurations describe <NAME>         # Show one configuration's properties
gcloud config configurations delete <NAME>

CLOUDSDK_ACTIVE_CONFIG_NAME=<NAME> gcloud ...        # Use a config for a single command via env var
gcloud <cmd> --project=<ID> --account=<EMAIL>        # Override project/account per invocation
gcloud <cmd> --impersonate-service-account=<SA_EMAIL>  # Run a command as a service account
```

---

## Projects & Organizations

```bash
gcloud projects list                                          # List projects you can see
gcloud projects list --filter="name:prod*" --format="table(projectId,name)"
gcloud projects describe <PROJECT_ID>                         # Show project metadata
gcloud projects create <PROJECT_ID> --name="<DISPLAY NAME>"   # Create a new project
gcloud projects create <PROJECT_ID> --organization=<ORG_ID>   # Create under an org
gcloud projects create <PROJECT_ID> --folder=<FOLDER_ID>      # Create under a folder
gcloud projects delete <PROJECT_ID>                           # Schedule deletion (30-day recovery window)
gcloud projects undelete <PROJECT_ID>                         # Restore a project pending deletion

gcloud projects get-iam-policy <PROJECT_ID>                   # Dump the project IAM policy
gcloud projects add-iam-policy-binding <PROJECT_ID> \
  --member="user:<EMAIL>" --role="roles/viewer"               # Grant a role
gcloud projects remove-iam-policy-binding <PROJECT_ID> \
  --member="serviceAccount:<SA_EMAIL>" --role="roles/editor"  # Revoke a role

gcloud organizations list                                     # List organizations you belong to
gcloud organizations describe <ORG_ID>
gcloud resource-manager folders list --organization=<ORG_ID>  # List folders in an org
gcloud resource-manager folders create --display-name="<NAME>" --organization=<ORG_ID>
```

---

## Billing

```bash
gcloud billing accounts list                                     # List billing accounts you can access
gcloud billing accounts describe <BILLING_ACCOUNT_ID>
gcloud billing projects describe <PROJECT_ID>                    # Which billing account a project uses
gcloud billing projects link <PROJECT_ID> --billing-account=<ID> # Attach billing to a project
gcloud billing projects unlink <PROJECT_ID>                      # Detach billing (stops billable services)
gcloud billing budgets list --billing-account=<ID>               # List budgets
gcloud billing budgets create --billing-account=<ID> \
  --display-name="Monthly cap" --budget-amount=100USD            # Create a budget
```

---

## Services / APIs

```bash
gcloud services list --enabled                       # APIs enabled on the current project
gcloud services list --available                     # All APIs that can be enabled
gcloud services enable run.googleapis.com            # Enable one API
gcloud services enable compute.googleapis.com iam.googleapis.com cloudbuild.googleapis.com
gcloud services disable <API>                        # Disable an API
gcloud services disable <API> --force                # Disable even if other services depend on it
gcloud services operations list                      # Check long-running enable/disable operations
```

Frequently enabled APIs: `run`, `cloudbuild`, `artifactregistry`, `secretmanager`, `sqladmin`,
`container` (GKE), `compute`, `cloudfunctions`, `pubsub`, `cloudscheduler`, `iam`,
`cloudresourcemanager`, `logging`, `monitoring`, `aiplatform` — each suffixed `.googleapis.com`.

---

## IAM & Service Accounts

```bash
gcloud iam service-accounts list                                       # List service accounts in the project
gcloud iam service-accounts create <SA_NAME> --display-name="<NAME>"   # Create a service account
gcloud iam service-accounts describe <SA_EMAIL>
gcloud iam service-accounts delete <SA_EMAIL>
gcloud iam service-accounts disable <SA_EMAIL>                         # Disable without deleting
gcloud iam service-accounts enable <SA_EMAIL>

gcloud iam service-accounts keys list --iam-account=<SA_EMAIL>              # List key IDs and expiry
gcloud iam service-accounts keys create key.json --iam-account=<SA_EMAIL>   # Download a new JSON key
gcloud iam service-accounts keys delete <KEY_ID> --iam-account=<SA_EMAIL>

# Let a principal impersonate a service account
gcloud iam service-accounts add-iam-policy-binding <SA_EMAIL> \
  --member="user:<EMAIL>" --role="roles/iam.serviceAccountTokenCreator"

gcloud iam roles list                                               # List predefined roles
gcloud iam roles list --project=<PROJECT_ID>                        # List custom roles in a project
gcloud iam roles describe roles/storage.objectViewer                # Show a role's permissions
gcloud iam roles create <ROLE_ID> --project=<PROJECT_ID> \
  --permissions=storage.objects.get,storage.objects.list \
  --title="<TITLE>"                                                 # Create a custom role
gcloud iam roles update <ROLE_ID> --project=<PROJECT_ID> --add-permissions=<PERM>
gcloud iam list-testable-permissions //cloudresourcemanager.googleapis.com/projects/<PROJECT_ID>

gcloud iam workload-identity-pools list --location=global           # WIF pools (keyless CI auth)
gcloud iam workload-identity-pools create <POOL_ID> --location=global
gcloud iam workload-identity-pools providers create-oidc <PROVIDER_ID> \
  --workload-identity-pool=<POOL_ID> --location=global \
  --issuer-uri="https://token.actions.githubusercontent.com" \
  --attribute-mapping="google.subject=assertion.sub"
```

Member prefixes: `user:`, `serviceAccount:`, `group:`, `domain:`, `allUsers`, `allAuthenticatedUsers`.

---

## Compute Engine (VMs)

```bash
gcloud compute instances list                                    # List all VMs across zones
gcloud compute instances describe <VM> --zone=<ZONE>
gcloud compute instances create <VM> \
  --zone=us-central1-a --machine-type=e2-medium \
  --image-family=debian-12 --image-project=debian-cloud \
  --boot-disk-size=20GB --tags=http-server                       # Create a VM
gcloud compute instances start <VM> --zone=<ZONE>
gcloud compute instances stop <VM> --zone=<ZONE>                 # Stop (disk billing continues)
gcloud compute instances reset <VM> --zone=<ZONE>                # Hard reboot
gcloud compute instances delete <VM> --zone=<ZONE>
gcloud compute instances delete <VM> --zone=<ZONE> --keep-disks=boot

gcloud compute ssh <VM> --zone=<ZONE>                            # SSH in (manages keys automatically)
gcloud compute ssh <VM> --zone=<ZONE> --tunnel-through-iap       # SSH without a public IP, via IAP
gcloud compute ssh <VM> --zone=<ZONE> --command="uptime"         # Run a single remote command
gcloud compute scp local.txt <VM>:~/ --zone=<ZONE>               # Copy files to a VM
gcloud compute scp <VM>:~/remote.log ./ --zone=<ZONE>            # Copy files from a VM

gcloud compute instances get-serial-port-output <VM> --zone=<ZONE>   # Boot/console logs for debugging
gcloud compute instances add-metadata <VM> --zone=<ZONE> \
  --metadata-from-file=startup-script=start.sh                       # Attach a startup script
gcloud compute instances set-machine-type <VM> --zone=<ZONE> \
  --machine-type=e2-standard-4                                       # Resize (VM must be stopped)
gcloud compute instances add-tags <VM> --zone=<ZONE> --tags=https-server   # Tags drive firewall rules

gcloud compute machine-types list --filter="zone:us-central1-a"   # Available machine types
gcloud compute zones list                                          # All zones and their status
gcloud compute regions list                                        # Regions with quota usage
gcloud compute images list --filter="family~debian"                # Public + custom images
gcloud compute images create <IMAGE> --source-disk=<DISK> --source-disk-zone=<ZONE>

gcloud compute disks list
gcloud compute disks create <DISK> --size=100GB --zone=<ZONE> --type=pd-balanced
gcloud compute disks resize <DISK> --size=200GB --zone=<ZONE>
gcloud compute instances attach-disk <VM> --disk=<DISK> --zone=<ZONE>
gcloud compute snapshots list
gcloud compute disks snapshot <DISK> --snapshot-names=<SNAP> --zone=<ZONE>

gcloud compute instance-templates list
gcloud compute instance-templates create <TPL> --machine-type=e2-medium \
  --image-family=debian-12 --image-project=debian-cloud
gcloud compute instance-groups managed list
gcloud compute instance-groups managed create <MIG> --template=<TPL> --size=3 --zone=<ZONE>
gcloud compute instance-groups managed resize <MIG> --size=5 --zone=<ZONE>
gcloud compute instance-groups managed set-autoscaling <MIG> --zone=<ZONE> \
  --max-num-replicas=10 --target-cpu-utilization=0.6
gcloud compute instance-groups managed rolling-action restart <MIG> --zone=<ZONE>
```

---

## Networking (VPC, Firewall, LB, DNS)

```bash
gcloud compute networks list                                      # List VPC networks
gcloud compute networks create <NET> --subnet-mode=custom
gcloud compute networks subnets list --filter="region:us-central1"
gcloud compute networks subnets create <SUBNET> --network=<NET> \
  --region=us-central1 --range=10.0.0.0/24

gcloud compute firewall-rules list                                # List firewall rules
gcloud compute firewall-rules create allow-http \
  --network=<NET> --allow=tcp:80,tcp:443 \
  --source-ranges=0.0.0.0/0 --target-tags=http-server             # Open ports to tagged VMs
gcloud compute firewall-rules delete allow-http

gcloud compute addresses list                                     # Reserved static IPs
gcloud compute addresses create <NAME> --region=us-central1       # Reserve a regional external IP
gcloud compute addresses create <NAME> --global                   # Reserve a global IP (for HTTPS LB)

gcloud compute routers create <ROUTER> --network=<NET> --region=us-central1
gcloud compute routers nats create <NAT> --router=<ROUTER> --region=us-central1 \
  --auto-allocate-nat-external-ips --nat-all-subnet-ip-ranges     # Egress for private VMs

gcloud compute health-checks create http <HC> --port=80
gcloud compute backend-services create <BS> --global --protocol=HTTP --health-checks=<HC>
gcloud compute url-maps create <MAP> --default-service=<BS>
gcloud compute target-http-proxies create <PROXY> --url-map=<MAP>
gcloud compute forwarding-rules create <FR> --global --target-http-proxy=<PROXY> --ports=80
gcloud compute ssl-certificates create <CERT> --domains=example.com --global   # Google-managed cert

gcloud dns managed-zones list                                     # Cloud DNS zones
gcloud dns managed-zones create <ZONE> --dns-name=example.com. --description=""
gcloud dns record-sets list --zone=<ZONE>
gcloud dns record-sets create www.example.com. --zone=<ZONE> --type=A --ttl=300 --rrdatas=1.2.3.4
gcloud dns record-sets update www.example.com. --zone=<ZONE> --type=A --ttl=300 --rrdatas=5.6.7.8
gcloud dns record-sets delete www.example.com. --zone=<ZONE> --type=A
```

---

## Cloud Storage

`gcloud storage` is the modern, faster replacement for `gsutil`.

```bash
gcloud storage buckets list                                       # List buckets in the project
gcloud storage buckets create gs://<BUCKET> --location=US --uniform-bucket-level-access
gcloud storage buckets describe gs://<BUCKET>
gcloud storage buckets delete gs://<BUCKET>
gcloud storage buckets update gs://<BUCKET> --versioning          # Enable object versioning

gcloud storage ls gs://<BUCKET>                                   # List objects
gcloud storage ls -l -r gs://<BUCKET>/**                          # Recursive long listing
gcloud storage cp file.txt gs://<BUCKET>/                         # Upload
gcloud storage cp gs://<BUCKET>/file.txt .                        # Download
gcloud storage cp -r ./dir gs://<BUCKET>/dir                      # Recursive copy
gcloud storage rsync ./dir gs://<BUCKET>/dir --recursive          # Sync a directory tree
gcloud storage mv gs://<BUCKET>/a gs://<BUCKET>/b                 # Move/rename
gcloud storage rm gs://<BUCKET>/file.txt
gcloud storage rm -r gs://<BUCKET>/prefix/                        # Delete a "folder"
gcloud storage cat gs://<BUCKET>/file.txt                         # Stream an object to stdout
gcloud storage du -s gs://<BUCKET>                                # Total size of a bucket
gcloud storage sign-url gs://<BUCKET>/f.txt --duration=1h \
  --private-key-file=key.json                                     # Generate a time-limited signed URL

gcloud storage objects update gs://<BUCKET>/f.txt --cache-control="public, max-age=3600"
gcloud storage buckets add-iam-policy-binding gs://<BUCKET> \
  --member=allUsers --role=roles/storage.objectViewer             # Make a bucket public (be careful)

# Legacy gsutil equivalents still in wide use
gsutil ls gs://<BUCKET>
gsutil -m cp -r ./dir gs://<BUCKET>/                              # -m = parallel transfers
gsutil iam ch allUsers:objectViewer gs://<BUCKET>
gsutil lifecycle set lifecycle.json gs://<BUCKET>                 # Apply object lifecycle rules
gsutil cors set cors.json gs://<BUCKET>                           # Apply a CORS policy
```

---

## Cloud Run

```bash
gcloud run deploy <SERVICE> --source .                            # Build from source and deploy
gcloud run deploy <SERVICE> --image=<REGION>-docker.pkg.dev/<PROJ>/<REPO>/<IMG>:<TAG> \
  --region=us-central1 --allow-unauthenticated
gcloud run services list                                          # List services across regions
gcloud run services describe <SERVICE> --region=<REGION>
gcloud run services delete <SERVICE> --region=<REGION>
gcloud run services update <SERVICE> --region=<REGION> \
  --memory=1Gi --cpu=2 --concurrency=80 --timeout=300 \
  --min-instances=0 --max-instances=10                            # Tune runtime resources

gcloud run services update <SERVICE> --region=<REGION> \
  --set-env-vars=KEY=VALUE,OTHER=VAL                              # Replace all env vars
gcloud run services update <SERVICE> --region=<REGION> \
  --update-env-vars=KEY=VALUE                                     # Add/change without clearing others
gcloud run services update <SERVICE> --region=<REGION> --remove-env-vars=KEY
gcloud run services update <SERVICE> --region=<REGION> \
  --set-secrets=API_KEY=<SECRET_NAME>:latest                      # Mount a Secret Manager secret

gcloud run revisions list --service=<SERVICE> --region=<REGION>
gcloud run services update-traffic <SERVICE> --region=<REGION> --to-latest
gcloud run services update-traffic <SERVICE> --region=<REGION> \
  --to-revisions=<REV_A>=90,<REV_B>=10                            # Canary traffic split
gcloud run services add-iam-policy-binding <SERVICE> --region=<REGION> \
  --member=allUsers --role=roles/run.invoker                      # Make publicly invocable

gcloud run jobs create <JOB> --image=<IMAGE> --region=<REGION>    # Run-to-completion job
gcloud run jobs execute <JOB> --region=<REGION> --wait
gcloud run jobs executions list --job=<JOB> --region=<REGION>
gcloud run services proxy <SERVICE> --region=<REGION> --port=8080 # Local authenticated proxy
```

---

## Cloud Functions

```bash
gcloud functions list                                             # List functions (all generations)
gcloud functions deploy <FN> --gen2 --runtime=nodejs20 \
  --region=us-central1 --source=. --entry-point=handler \
  --trigger-http --allow-unauthenticated                          # Deploy an HTTP function
gcloud functions deploy <FN> --gen2 --runtime=python312 \
  --trigger-topic=<TOPIC>                                         # Pub/Sub-triggered function
gcloud functions deploy <FN> --gen2 --trigger-bucket=<BUCKET>     # GCS-triggered function
gcloud functions describe <FN> --region=<REGION>
gcloud functions delete <FN> --region=<REGION>
gcloud functions call <FN> --region=<REGION> --data='{"k":"v"}'   # Invoke for testing
gcloud functions logs read <FN> --region=<REGION> --limit=50
gcloud functions deploy <FN> --set-env-vars=KEY=VALUE
gcloud functions deploy <FN> --set-secrets=API_KEY=<SECRET>:latest
```

---

## App Engine

```bash
gcloud app create --region=us-central                # One-time app creation per project
gcloud app deploy                                    # Deploy using app.yaml in the current directory
gcloud app deploy --no-promote                       # Deploy without routing traffic to it
gcloud app deploy --version=<VERSION>
gcloud app browse                                    # Open the deployed app in a browser
gcloud app describe                                  # Show the app's region and settings
gcloud app versions list                             # List versions and traffic split
gcloud app versions delete <VERSION>
gcloud app services list
gcloud app services set-traffic <SERVICE> --splits=<VERSION>=1
gcloud app logs tail -s default                      # Stream logs for a service
gcloud app instances list
```

---

## Google Kubernetes Engine (GKE)

```bash
gcloud container clusters list                                    # List clusters
gcloud container clusters create <CLUSTER> --zone=<ZONE> --num-nodes=3
gcloud container clusters create-auto <CLUSTER> --region=<REGION> # Autopilot cluster
gcloud container clusters describe <CLUSTER> --zone=<ZONE>
gcloud container clusters delete <CLUSTER> --zone=<ZONE>
gcloud container clusters get-credentials <CLUSTER> --zone=<ZONE> # Write kubeconfig for kubectl
gcloud container clusters resize <CLUSTER> --num-nodes=5 --zone=<ZONE>
gcloud container clusters upgrade <CLUSTER> --master --zone=<ZONE>

gcloud container node-pools list --cluster=<CLUSTER> --zone=<ZONE>
gcloud container node-pools create <POOL> --cluster=<CLUSTER> --zone=<ZONE> \
  --machine-type=e2-standard-4 --num-nodes=2 \
  --enable-autoscaling --min-nodes=1 --max-nodes=5
gcloud container node-pools delete <POOL> --cluster=<CLUSTER> --zone=<ZONE>
gcloud container operations list                                  # Track cluster operations
gcloud container get-server-config --zone=<ZONE>                  # Available Kubernetes versions
```

---

## Artifact Registry & Container Registry

```bash
gcloud artifacts repositories list                                # List repos across locations
gcloud artifacts repositories create <REPO> \
  --repository-format=docker --location=us-central1 \
  --description="Container images"                                # Create a Docker repo
gcloud artifacts repositories describe <REPO> --location=<LOC>
gcloud artifacts repositories delete <REPO> --location=<LOC>
gcloud artifacts docker images list <LOC>-docker.pkg.dev/<PROJ>/<REPO>
gcloud artifacts docker images delete <IMAGE_PATH>:<TAG> --delete-tags
gcloud artifacts docker tags list <LOC>-docker.pkg.dev/<PROJ>/<REPO>/<IMG>
gcloud artifacts packages list --repository=<REPO> --location=<LOC>
gcloud artifacts print-settings npm --repository=<REPO> --location=<LOC>   # Emit .npmrc config
gcloud auth configure-docker <LOC>-docker.pkg.dev                 # Enable docker push/pull

# Legacy Container Registry (gcr.io)
gcloud container images list
gcloud container images list-tags gcr.io/<PROJ>/<IMG>
gcloud container images delete gcr.io/<PROJ>/<IMG>:<TAG> --force-delete-tags
```

---

## Cloud Build

```bash
gcloud builds submit --tag=<LOC>-docker.pkg.dev/<PROJ>/<REPO>/<IMG>:<TAG>   # Build & push an image
gcloud builds submit --config=cloudbuild.yaml .                   # Run a multi-step build config
gcloud builds submit --config=cloudbuild.yaml --substitutions=_ENV=prod
gcloud builds list --limit=10                                     # Recent builds and their status
gcloud builds log <BUILD_ID>                                      # Print a build's full log
gcloud builds log <BUILD_ID> --stream                             # Follow a running build
gcloud builds cancel <BUILD_ID>
gcloud builds triggers list                                       # List CI triggers
gcloud builds triggers create github --repo-name=<REPO> --repo-owner=<OWNER> \
  --branch-pattern="^main$" --build-config=cloudbuild.yaml
gcloud builds triggers run <TRIGGER> --branch=main                # Manually fire a trigger
gcloud builds triggers delete <TRIGGER>
```

---

## Cloud SQL

```bash
gcloud sql instances list                                         # List database instances
gcloud sql instances create <INSTANCE> --database-version=POSTGRES_15 \
  --tier=db-f1-micro --region=us-central1
gcloud sql instances describe <INSTANCE>
gcloud sql instances patch <INSTANCE> --tier=db-custom-2-7680     # Change machine size
gcloud sql instances patch <INSTANCE> --authorized-networks=1.2.3.4/32
gcloud sql instances restart <INSTANCE>
gcloud sql instances delete <INSTANCE>

gcloud sql databases list --instance=<INSTANCE>
gcloud sql databases create <DB> --instance=<INSTANCE>
gcloud sql users list --instance=<INSTANCE>
gcloud sql users create <USER> --instance=<INSTANCE> --password=<PW>
gcloud sql users set-password <USER> --instance=<INSTANCE> --password=<PW>

gcloud sql connect <INSTANCE> --user=postgres                     # Open a psql/mysql shell
gcloud sql backups list --instance=<INSTANCE>
gcloud sql backups create --instance=<INSTANCE>
gcloud sql backups restore <BACKUP_ID> --restore-instance=<INSTANCE>
gcloud sql export sql <INSTANCE> gs://<BUCKET>/dump.sql --database=<DB>
gcloud sql import sql <INSTANCE> gs://<BUCKET>/dump.sql --database=<DB>
gcloud sql operations list --instance=<INSTANCE>                  # Track long-running admin operations
```

---

## Firestore & Datastore

```bash
gcloud firestore databases list                                   # List Firestore databases
gcloud firestore databases create --location=nam5 --type=firestore-native
gcloud firestore indexes composite list                           # Composite indexes
gcloud firestore export gs://<BUCKET>/backup                      # Export all collections
gcloud firestore export gs://<BUCKET>/backup --collection-ids=users,orders
gcloud firestore import gs://<BUCKET>/backup/<TIMESTAMP>
gcloud firestore operations list                                  # Track export/import jobs
gcloud datastore indexes create index.yaml                        # Datastore-mode index creation
```

---

## Bigtable & Spanner

```bash
gcloud bigtable instances list
gcloud bigtable instances create <INSTANCE> --display-name="<NAME>" \
  --cluster-config=id=<CLUSTER>,zone=us-central1-b,nodes=1
gcloud bigtable clusters list --instances=<INSTANCE>
gcloud bigtable instances tables list --instances=<INSTANCE>

gcloud spanner instances list
gcloud spanner instances create <INSTANCE> --config=regional-us-central1 \
  --description="<DESC>" --nodes=1
gcloud spanner databases list --instance=<INSTANCE>
gcloud spanner databases create <DB> --instance=<INSTANCE>
gcloud spanner databases ddl describe <DB> --instance=<INSTANCE>  # Show the schema
gcloud spanner databases execute-sql <DB> --instance=<INSTANCE> --sql="SELECT 1"
gcloud spanner backups list --instance=<INSTANCE>
```

---

## BigQuery (bq)

BigQuery uses the separate `bq` CLI shipped with the SDK.

```bash
bq ls                                             # List datasets in the default project
bq ls <PROJECT>:<DATASET>                         # List tables in a dataset
bq mk --dataset --location=US <PROJECT>:<DATASET> # Create a dataset
bq mk --table <DATASET>.<TABLE> name:STRING,age:INTEGER
bq rm -r -f <DATASET>                             # Delete a dataset and all its tables
bq show <DATASET>.<TABLE>                         # Show schema and metadata
bq head -n 10 <DATASET>.<TABLE>                   # Preview rows without running a query

bq query --use_legacy_sql=false 'SELECT COUNT(*) FROM `proj.ds.tbl`'
bq query --use_legacy_sql=false --dry_run 'SELECT ...'      # Estimate bytes scanned (cost check)
bq query --use_legacy_sql=false --destination_table=<DS>.<TBL> --replace 'SELECT ...'

bq load --source_format=CSV --autodetect <DATASET>.<TABLE> gs://<BUCKET>/data.csv
bq load --source_format=NEWLINE_DELIMITED_JSON <DATASET>.<TABLE> gs://<BUCKET>/data.json schema.json
bq extract <DATASET>.<TABLE> gs://<BUCKET>/export-*.csv     # Export a table to GCS
bq cp <DS>.<SRC> <DS>.<DST>                                 # Copy a table
bq ls -j -a --max_results=20                                # Recent jobs (all users)
bq show -j <JOB_ID>                                         # Inspect one job
```

---

## Pub/Sub

```bash
gcloud pubsub topics list
gcloud pubsub topics create <TOPIC>
gcloud pubsub topics delete <TOPIC>
gcloud pubsub topics publish <TOPIC> --message="hello" --attribute=key=value
gcloud pubsub subscriptions list
gcloud pubsub subscriptions create <SUB> --topic=<TOPIC>          # Pull subscription
gcloud pubsub subscriptions create <SUB> --topic=<TOPIC> \
  --push-endpoint=https://<URL> --push-auth-service-account=<SA>  # Push subscription
gcloud pubsub subscriptions pull <SUB> --auto-ack --limit=10      # Read messages for debugging
gcloud pubsub subscriptions seek <SUB> --time=2026-01-01T00:00:00Z  # Replay or purge by timestamp
gcloud pubsub subscriptions update <SUB> --ack-deadline=60
gcloud pubsub subscriptions delete <SUB>
gcloud pubsub schemas list
```

---

## Secret Manager

```bash
gcloud secrets list                                               # List secrets in the project
gcloud secrets create <SECRET> --replication-policy=automatic
echo -n "s3cr3t" | gcloud secrets versions add <SECRET> --data-file=-   # Add a version from stdin
gcloud secrets versions add <SECRET> --data-file=./secret.txt
gcloud secrets versions access latest --secret=<SECRET>           # Read the current value
gcloud secrets versions list <SECRET>
gcloud secrets versions disable <VERSION> --secret=<SECRET>
gcloud secrets versions destroy <VERSION> --secret=<SECRET>       # Irreversibly delete a version
gcloud secrets delete <SECRET>
gcloud secrets add-iam-policy-binding <SECRET> \
  --member="serviceAccount:<SA_EMAIL>" --role="roles/secretmanager.secretAccessor"


gcloud secrets list --project=cverai-v2-dev --format="value(name.basename())" | tr -d '\r' | while IFS= read -r s; do   printf '\n===== %s =====\n' "$s";   gcloud secrets versions access latest --secret="$s" --project=cverai-v2-dev;   echo; done

gcloud secrets list --project=cverai-v2-dev --format="value(name.basename())"
```

---

## KMS (Key Management)

```bash
gcloud kms keyrings list --location=global
gcloud kms keyrings create <RING> --location=global
gcloud kms keys list --keyring=<RING> --location=global
gcloud kms keys create <KEY> --keyring=<RING> --location=global --purpose=encryption
gcloud kms keys versions list --key=<KEY> --keyring=<RING> --location=global
gcloud kms encrypt --key=<KEY> --keyring=<RING> --location=global \
  --plaintext-file=in.txt --ciphertext-file=out.enc
gcloud kms decrypt --key=<KEY> --keyring=<RING> --location=global \
  --ciphertext-file=out.enc --plaintext-file=dec.txt
gcloud kms keys versions rotate --key=<KEY> --keyring=<RING> --location=global
```

---

## Logging

```bash
gcloud logging logs list                                          # List log names in the project
gcloud logging read "severity>=ERROR" --limit=50 --freshness=1d   # Query logs
gcloud logging read 'resource.type="cloud_run_revision" AND resource.labels.service_name="<SVC>"' \
  --limit=100 --format="table(timestamp,severity,textPayload)"
gcloud logging read 'jsonPayload.message=~"timeout"' --limit=20
gcloud logging tail 'resource.type="cloud_run_revision"'          # Live stream (needs beta component)
gcloud logging write <LOG_NAME> "message text" --severity=INFO    # Write a custom log entry
gcloud logging sinks list                                         # Log export sinks
gcloud logging sinks create <SINK> storage.googleapis.com/<BUCKET> \
  --log-filter='severity>=WARNING'
gcloud logging sinks delete <SINK>
gcloud logging metrics list                                       # Log-based metrics
```

Common log filter fields: `resource.type`, `resource.labels.*`, `severity`, `timestamp`,
`textPayload`, `jsonPayload.*`, `httpRequest.status`, `labels.*`, `trace`.

---

## Monitoring & Error Reporting

```bash
gcloud monitoring dashboards list
gcloud monitoring dashboards create --config-from-file=dashboard.json
gcloud monitoring channel-descriptors list                        # Notification channel types
gcloud alpha monitoring policies list                             # Alerting policies
gcloud alpha monitoring policies create --policy-from-file=policy.yaml
gcloud beta error-reporting events list --service=<SERVICE>       # Recent grouped errors
gcloud beta error-reporting events delete                         # Clear all error stats
```

---

## Cloud Scheduler & Tasks

```bash
gcloud scheduler jobs list --location=us-central1
gcloud scheduler jobs create http <JOB> --location=us-central1 \
  --schedule="0 * * * *" --uri="https://example.com/cron" \
  --http-method=POST --oidc-service-account-email=<SA_EMAIL>      # Hourly authenticated HTTP job
gcloud scheduler jobs create pubsub <JOB> --location=us-central1 \
  --schedule="*/5 * * * *" --topic=<TOPIC> --message-body="tick"
gcloud scheduler jobs run <JOB> --location=us-central1            # Trigger immediately
gcloud scheduler jobs pause <JOB> --location=us-central1
gcloud scheduler jobs resume <JOB> --location=us-central1
gcloud scheduler jobs delete <JOB> --location=us-central1

gcloud tasks queues list --location=us-central1
gcloud tasks queues create <QUEUE> --location=us-central1
gcloud tasks queues pause <QUEUE> --location=us-central1
gcloud tasks queues purge <QUEUE> --location=us-central1          # Drop all queued tasks
gcloud tasks list --queue=<QUEUE> --location=us-central1
```

---

## Workflows & Eventarc

```bash
gcloud workflows list --location=us-central1
gcloud workflows deploy <WORKFLOW> --source=workflow.yaml --location=us-central1
gcloud workflows run <WORKFLOW> --location=us-central1 --data='{"k":"v"}'
gcloud workflows executions list --workflow=<WORKFLOW> --location=us-central1
gcloud workflows executions describe <EXEC_ID> --workflow=<WORKFLOW> --location=us-central1

gcloud eventarc triggers list --location=us-central1
gcloud eventarc triggers create <TRIGGER> --location=us-central1 \
  --destination-run-service=<SERVICE> \
  --event-filters="type=google.cloud.storage.object.v1.finalized" \
  --event-filters="bucket=<BUCKET>" --service-account=<SA_EMAIL>
gcloud eventarc providers list --location=us-central1             # Available event sources
```

---

## Composer, Dataflow, Dataproc

```bash
gcloud composer environments list --locations=us-central1         # Managed Airflow environments
gcloud composer environments create <ENV> --location=us-central1 \
  --image-version=composer-2-airflow-2
gcloud composer environments storage dags import --environment=<ENV> \
  --location=us-central1 --source=dag.py                          # Upload a DAG
gcloud composer environments run <ENV> --location=us-central1 dags list

gcloud dataflow jobs list --region=us-central1
gcloud dataflow jobs describe <JOB_ID> --region=us-central1
gcloud dataflow jobs cancel <JOB_ID> --region=us-central1
gcloud dataflow jobs drain <JOB_ID> --region=us-central1          # Graceful stop for streaming jobs
gcloud dataflow flex-template run <JOB> \
  --template-file-gcs-location=gs://... --region=us-central1

gcloud dataproc clusters list --region=us-central1
gcloud dataproc clusters create <CLUSTER> --region=us-central1 --single-node
gcloud dataproc jobs submit pyspark job.py --cluster=<CLUSTER> --region=us-central1
gcloud dataproc jobs list --region=us-central1
gcloud dataproc clusters delete <CLUSTER> --region=us-central1
```

---

## Vertex AI

```bash
gcloud ai models list --region=us-central1                        # Registered models
gcloud ai models upload --region=us-central1 --display-name=<NAME> \
  --container-image-uri=<IMAGE>
gcloud ai endpoints list --region=us-central1
gcloud ai endpoints create --region=us-central1 --display-name=<NAME>
gcloud ai endpoints deploy-model <ENDPOINT_ID> --region=us-central1 \
  --model=<MODEL_ID> --display-name=<NAME> --machine-type=n1-standard-2
gcloud ai endpoints predict <ENDPOINT_ID> --region=us-central1 --json-request=req.json
gcloud ai custom-jobs create --region=us-central1 --display-name=<NAME> --config=config.yaml
gcloud ai custom-jobs stream-logs <JOB_ID> --region=us-central1
gcloud ai operations list --region=us-central1
```

---

## Resource Manager & Asset Inventory

```bash
gcloud asset search-all-resources --scope=projects/<PROJECT_ID>   # Find any resource in a scope
gcloud asset search-all-resources --scope=organizations/<ORG_ID> \
  --asset-types="compute.googleapis.com/Instance"
gcloud asset search-all-iam-policies --scope=projects/<PROJECT_ID> --query="policy:<EMAIL>"
gcloud asset export --project=<PROJECT_ID> --output-path=gs://<BUCKET>/assets.json \
  --content-type=resource
gcloud asset get-history --project=<PROJECT_ID> --asset-names=<FULL_NAME> \
  --start-time=2026-01-01T00:00:00Z                               # Change history for an asset

gcloud org-policies list --project=<PROJECT_ID>                   # Effective org policies
gcloud org-policies describe constraints/compute.requireOsLogin --project=<PROJECT_ID>
gcloud org-policies set-policy policy.yaml
gcloud recommender recommendations list --project=<PROJECT_ID> \
  --location=us-central1-a \
  --recommender=google.compute.instance.MachineTypeRecommender    # Rightsizing suggestions

gcloud identity groups list --organization=<ORG_ID>               # Cloud Identity groups
gcloud identity groups memberships list --group-email=<GROUP_EMAIL>
gcloud identity groups memberships add --group-email=<GROUP> --member-email=<USER>
```

---

## Deployment Manager

```bash
gcloud deployment-manager deployments list
gcloud deployment-manager deployments create <DEPLOY> --config=config.yaml
gcloud deployment-manager deployments update <DEPLOY> --config=config.yaml
gcloud deployment-manager deployments delete <DEPLOY>
gcloud deployment-manager deployments describe <DEPLOY>
gcloud deployment-manager types list                              # Supported resource types
```

---

## Formatting, Filtering & Scripting

```bash
gcloud <cmd> --format=json                                        # Machine-readable output
gcloud <cmd> --format=yaml
gcloud <cmd> --format="value(name)"                               # Bare values, ideal for shell loops
gcloud <cmd> --format="table(name,status,zone.basename())"        # Custom table columns
gcloud <cmd> --format="csv(name,status)"
gcloud <cmd> --format="flattened"                                 # Fully expanded key=value output
gcloud <cmd> --format="json(name)" | jq -r '.[].name'

gcloud <cmd> --filter="status=RUNNING"
gcloud <cmd> --filter="name~^prod- AND zone:us-central1"          # ~ regex match, : substring match
gcloud <cmd> --filter="NOT labels.env=dev"
gcloud <cmd> --filter="createTime>'2026-01-01'"
gcloud <cmd> --sort-by="~createTime" --limit=10                   # ~ prefix = descending

gcloud <cmd> --quiet                                              # Auto-confirm prompts (for scripts)
gcloud <cmd> --verbosity=debug                                    # Verbose diagnostics
gcloud <cmd> --log-http                                           # Log the raw API requests/responses
gcloud <cmd> --async                                              # Return immediately on long operations
gcloud topic filters                                              # Built-in docs on the filter syntax
gcloud topic formats                                              # Built-in docs on output formats
gcloud topic projections                                          # Built-in docs on projection syntax
gcloud topic escaping                                             # How to escape list-valued flags
```

---

## Components & Alpha/Beta Tracks

```bash
gcloud alpha <cmd>                              # Alpha track: newest, may break without notice
gcloud beta <cmd>                               # Beta track: stable-ish preview features
gcloud components install alpha beta            # Install the preview command groups
gcloud config set survey/disable_prompts true   # Silence survey prompts in CI
gcloud beta interactive                         # Interactive shell with inline help and completion
```

---

## Troubleshooting

```bash
gcloud info --run-diagnostics                        # Test network reachability and credentials
gcloud auth list                                     # Confirm which account is active
gcloud config list                                   # Confirm project/region defaults
gcloud <cmd> --log-http --verbosity=debug            # See the exact API call and error body
gcloud projects get-iam-policy $(gcloud config get-value project) \
  --flatten="bindings[].members" \
  --filter="bindings.members:<EMAIL>" \
  --format="value(bindings.role)"                    # Which roles does this principal actually hold?
gcloud services list --enabled | grep <api>          # Is the API turned on?
gcloud compute operations list --filter="status!=DONE"   # Stuck compute operations
```

Common causes when a command fails:

- **PERMISSION_DENIED** — missing IAM role, or the API is disabled on the project.
- **NOT_FOUND** — wrong `--project`, `--region`, or `--zone` for the resource.
- **403 on billing** — the project has no billing account linked.
- **Quota exceeded** — check `gcloud compute regions describe <REGION>` for quota usage.

---

## Common One-Liner Recipes

```bash
# Current project ID (useful in scripts)
PROJECT_ID=$(gcloud config get-value project)

# Project number (needed for default service account names)
gcloud projects describe $PROJECT_ID --format="value(projectNumber)"

# Delete every stopped VM in the project
gcloud compute instances list --filter="status=TERMINATED" --format="value(name,zone)" |
  while read n z; do gcloud compute instances delete "$n" --zone="$z" --quiet; done

# List all service accounts and their roles on the project
gcloud projects get-iam-policy $PROJECT_ID --flatten="bindings[].members" \
  --filter="bindings.members:serviceAccount" \
  --format="table(bindings.members,bindings.role)"

# Grab a Cloud Run service URL
gcloud run services describe <SVC> --region=<REGION> --format="value(status.url)"

# Call an authenticated Cloud Run service
curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" \
  "$(gcloud run services describe <SVC> --region=<REGION> --format='value(status.url)')"

# Enable a standard set of APIs on a new project
gcloud services enable run.googleapis.com cloudbuild.googleapis.com \
  artifactregistry.googleapis.com secretmanager.googleapis.com logging.googleapis.com

# Read the last 50 errors from a Cloud Run service
gcloud logging read 'resource.type="cloud_run_revision" AND severity>=ERROR' \
  --limit=50 --format="table(timestamp,textPayload)"

# Find the biggest objects in a bucket
gcloud storage ls -l -r "gs://<BUCKET>/**" | sort -rn | head -20

# Copy a secret's value into an env var
export API_KEY=$(gcloud secrets versions access latest --secret=<SECRET>)

# Delete all untagged images in an Artifact Registry repo
gcloud artifacts docker images list <LOC>-docker.pkg.dev/$PROJECT_ID/<REPO> \
  --include-tags --filter="-tags:*" --format="value(version)" |
  while read v; do
    gcloud artifacts docker images delete "<LOC>-docker.pkg.dev/$PROJECT_ID/<REPO>@$v" --quiet
  done
```

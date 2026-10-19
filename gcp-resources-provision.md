# CREATE VPC FOR CLOUD SQL

### 1. Create a VPC (if not exists)

gcloud compute networks create my-vpc \
 --subnet-mode=auto

### 2. Allocate IP range for private service connection

gcloud compute addresses create google-managed-services-my-vpc \
 --global \
 --purpose=VPC_PEERING \
 --prefix-length=16 \
 --network=my-vpc

### 3. Create private connection

gcloud services vpc-peerings connect \
 --service=servicenetworking.googleapis.com \
 --ranges=google-managed-services-my-vpc \
 --network=my-vpc

### 4. Update your Cloud SQL instance

gcloud sql instances patch YOUR_INSTANCE_NAME \
 --network=projects/YOUR_PROJECT_ID/global/networks/my-vpc \
 --no-assign-ip

### Enable IAM Database Authentication

gcloud sql instances patch YOUR_INSTANCE_NAME \
 --database-flags=cloudsql.iam_authentication=on

# Create service account

gcloud iam service-accounts create cloudsql-api-sa \
 --display-name="Cloud SQL API Service Account"

# Grant Cloud SQL Client role

gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
 --member="serviceAccount:cloudsql-api-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
 --role="roles/cloudsql.client"

# Create IAM database user

gcloud sql users create cloudsql-api-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com \
 --instance=YOUR_INSTANCE_NAME \
 --type=CLOUD_IAM_SERVICE_ACCOUNT

# Enable SSL/TLS enforcement

gcloud sql instances patch YOUR_INSTANCE_NAME \
 --require-ssl

# Enable automatic backups

gcloud sql instances patch YOUR_INSTANCE_NAME \
 --backup-start-time=03:00 \
 --retained-backups-count=30

# Enable point-in-time recovery

gcloud sql instances patch YOUR_INSTANCE_NAME \
 --enable-bin-log

# Enable deletion protection

gcloud sql instances patch YOUR_INSTANCE_NAME \
 --deletion-protection

# To get the connection name

gcloud sql instances describe cverai --format="value(connectionName)"

# Get service account details

gcloud iam service-accounts get-iam-policy github-actions-deployer@pelagic-gist-459620-q8.iam.gserviceaccount.com

gcloud projects get-iam-policy pelagic-gist-459620-q8 --flatten="bindings[].members" --filter="bindings.members:serviceAccount:github-actions-deployer@pelagic-gist-459620-q8.iam.gserviceaccount.com"

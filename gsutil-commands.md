# Logout
gcloud auth revoke
gcloud auth revoke <ACCOUNT_EMAIL>

# list login accounts
gcloud auth list

# Login
gcloud auth login

# Update
gcloud components update

# To revert your CLI to the previously installed version, you may run:
gcloud components update --version 527.0.0

# To set the active account, run:
gcloud config set account `ACCOUNT`

# List all buckets in your project
gsutil ls

# List with details (size, updated time)
gsutil ls -L

# List buckets in specific project
gsutil ls -p cverai

**Initialize gcloud:**
```bash
gcloud init
```

Follow the prompts:
1. Login to your Google account (opens browser)
2. Select your project (cverai in your case)
3. Set default region (us-east1 or your preferred region)

**Alternative Login (if needed):**
```bash
# Login with your Google account
gcloud auth login

# List accounts
gcloud auth list

# Set active account
gcloud config set account YOUR_EMAIL@gmail.com
```

**Set Your Project:**
```bash
# List all projects
gcloud projects list

# Set active project
gcloud config set project cverai

# Verify current config
gcloud config list
```

---

## Part 2: Bucket Operations

### 2.1 List Buckets

```bash
# List all buckets in your project
gsutil ls

# List with details (size, updated time)
gsutil ls -L

# List buckets in specific project
gsutil ls -p cverai
```

### 2.2 Create Buckets

```bash
# Create a bucket (must be globally unique name)
gsutil mb gs://my-new-bucket-name

# Create with specific location
gsutil mb -l us-east1 gs://my-bucket

# Create with specific storage class
gsutil mb -c STANDARD gs://my-bucket
gsutil mb -c NEARLINE gs://my-archive-bucket
gsutil mb -c COLDLINE gs://my-cold-bucket

# Create with multiple options
gsutil mb -p cverai -c STANDARD -l us-east1 gs://my-bucket
```

**Storage Classes:**
- `STANDARD` - Frequent access
- `NEARLINE` - Once per month access
- `COLDLINE` - Once per quarter access
- `ARCHIVE` - Once per year access

### 2.3 Delete Buckets

```bash
# Delete empty bucket
gsutil rb gs://bucket-name

# Delete bucket and all contents (CAREFUL!)
gsutil rm -r gs://bucket-name
```

### 2.4 Get Bucket Information

```bash
# Get bucket details
gsutil ls -L -b gs://cverai

# Get bucket location
gsutil ls -L -b gs://cverai | grep Location

# Get storage class
gsutil ls -L -b gs://cverai | grep "Storage class"
```

---

## Part 3: Object Operations (Files)

### 3.1 Upload Files

```bash
# Upload single file
gsutil cp myfile.txt gs://cverai/

# Upload to specific folder
gsutil cp myfile.txt gs://cverai/documents/

# Upload multiple files
gsutil cp file1.txt file2.txt gs://cverai/

# Upload entire directory
gsutil cp -r my-folder/ gs://cverai/

# Upload with progress indicator
gsutil -m cp -r my-folder/ gs://cverai/
```

**Upload Options:**
```bash
# Parallel upload (faster for multiple files)
gsutil -m cp *.jpg gs://cverai/images/

# Resume interrupted uploads
gsutil -o GSUtil:parallel_composite_upload_threshold=150M cp large-file.zip gs://cverai/

# Set storage class during upload
gsutil cp -s NEARLINE myfile.txt gs://cverai/

# Set metadata during upload
gsutil -h "Content-Type:text/plain" cp myfile.txt gs://cverai/
```

### 3.2 Download Files

```bash
# Download single file
gsutil cp gs://cverai/myfile.txt .

# Download to specific location
gsutil cp gs://cverai/myfile.txt C:/Downloads/

# Download entire folder
gsutil cp -r gs://cverai/documents/ .

# Download all files matching pattern
gsutil cp gs://cverai/*.jpg ./images/

# Parallel download (faster)
gsutil -m cp -r gs://cverai/large-folder/ .
```

### 3.3 List Files

```bash
# List all objects in bucket
gsutil ls gs://cverai-public-assets

# List with details
gsutil ls -l gs://cverai

# List with human-readable sizes
gsutil ls -lh gs://cverai

# List recursively (all subdirectories)
gsutil ls -r gs://cverai

# List with full details
gsutil ls -L gs://cverai/myfile.txt

# List with wildcard
gsutil ls gs://cverai/*.pdf
gsutil ls gs://cverai/documents/**/*.txt
```

### CORS SETUP

```bash 
gsutil cors set cors.json gs://cverai
gsutil cors get gs://cverai```

### 3.4 Delete Files

```bash
# Delete single file
gsutil rm gs://cverai/myfile.txt

# Delete parallel, multithread the deletion process.
gsutil -m rm -r gs://cverai/**


# Delete multiple files
gsutil rm gs://cverai/file1.txt gs://cverai/file2.txt

# Delete all files in folder
gsutil rm gs://cverai/old-folder/**

# Delete with wildcard
gsutil rm gs://cverai/*.tmp

# Parallel delete (faster)
gsutil -m rm gs://cverai/large-folder/**
```

### 3.5 Move & Rename Files

```bash
# Move file (rename)
gsutil mv gs://cverai/oldname.txt gs://cverai/newname.txt

# Move to different folder
gsutil mv gs://cverai/file.txt gs://cverai/documents/file.txt

# Move between buckets
gsutil mv gs://old-bucket/file.txt gs://new-bucket/file.txt

# Move entire folder
gsutil mv gs://cverai/old-folder gs://cverai/new-folder
```

### 3.6 Copy Files

```bash
# Copy within same bucket
gsutil cp gs://cverai/file.txt gs://cverai/backup/file.txt

# Copy between buckets
gsutil cp gs://cverai/file.txt gs://other-bucket/

# Copy entire folder
gsutil cp -r gs://cverai/folder/ gs://other-bucket/

# Parallel copy (faster)
gsutil -m cp -r gs://cverai/large-folder/ gs://backup-bucket/
```

---

## Part 4: Synchronization

### 4.1 Sync Local to Cloud

```bash
# Sync local folder to bucket (like rsync)
gsutil rsync -r ./local-folder gs://cverai/remote-folder

# Sync and delete files not in source
gsutil rsync -r -d ./local-folder gs://cverai/remote-folder

# Dry run (preview changes)
gsutil rsync -r -n ./local-folder gs://cverai/remote-folder

# Sync with exclusions
gsutil rsync -r -x ".*\.tmp$|.*\.log$" ./local-folder gs://cverai/
```

### 4.2 Sync Cloud to Local

```bash
# Sync bucket to local folder
gsutil rsync -r gs://cverai/remote-folder ./local-folder

# Two-way sync (use carefully!)
gsutil rsync -r -d ./local-folder gs://cverai/remote-folder
```

---

## Part 5: Permissions & Access Control

### 5.1 Make Files Public

```bash
# Make single file public
gsutil acl ch -u AllUsers:R gs://cverai/public-file.txt

# Make all files in folder public
gsutil -m acl ch -r -u AllUsers:R gs://cverai/public-folder/

# Make entire bucket public
gsutil iam ch allUsers:objectViewer gs://cverai
```

### 5.2 Make Files Private

```bash
# Remove public access from file
gsutil acl ch -d AllUsers gs://cverai/file.txt

# Remove public access from bucket
gsutil iam ch -d allUsers:objectViewer gs://cverai
```

### 5.3 Grant Specific User Access

```bash
# Grant read access to specific user
gsutil acl ch -u user@example.com:R gs://cverai/file.txt

# Grant write access
gsutil acl ch -u user@example.com:W gs://cverai/file.txt

# Grant full control
gsutil acl ch -u user@example.com:O gs://cverai/file.txt
```

### 5.4 View Permissions

```bash
# View bucket IAM policy
gsutil iam get gs://cverai

# View object ACL
gsutil acl get gs://cverai/file.txt

# View bucket ACL
gsutil acl get gs://cverai
```

### 5.5 Set Bucket-Level Permissions

```bash
# Grant storage admin to user
gsutil iam ch user:user@example.com:roles/storage.admin gs://cverai

# Grant object viewer
gsutil iam ch user:user@example.com:roles/storage.objectViewer gs://cverai

# Grant object creator
gsutil iam ch user:user@example.com:roles/storage.objectCreator gs://cverai
```

---

## Part 6: Metadata & Properties

### 6.1 View Metadata

```bash
# View object metadata
gsutil stat gs://cverai/myfile.txt

# View with full details
gsutil ls -L gs://cverai/myfile.txt
```

### 6.2 Set Metadata

```bash
# Set Content-Type
gsutil setmeta -h "Content-Type:text/html" gs://cverai/file.html

# Set Cache-Control
gsutil setmeta -h "Cache-Control:public, max-age=3600" gs://cverai/file.js

# Set custom metadata
gsutil setmeta -h "x-goog-meta-author:John Doe" gs://cverai/file.txt

# Set multiple headers
gsutil setmeta -h "Content-Type:image/jpeg" -h "Cache-Control:max-age=86400" gs://cverai/image.jpg
```

### 6.3 Set Storage Class

```bash
# Change storage class of object
gsutil rewrite -s NEARLINE gs://cverai/archive-file.txt

# Change for all objects in folder
gsutil -m rewrite -s COLDLINE gs://cverai/old-data/**

# Change bucket default storage class
gsutil defstorageclass set NEARLINE gs://cverai
```

---

## Part 7: Lifecycle Management

### 7.1 Set Lifecycle Rules

Create a lifecycle JSON file:

```json
{
  "lifecycle": {
    "rule": [
      {
        "action": {"type": "Delete"},
        "condition": {"age": 30}
      },
      {
        "action": {"type": "SetStorageClass", "storageClass": "NEARLINE"},
        "condition": {"age": 90}
      }
    ]
  }
}
```

Apply lifecycle rules:
```bash
# Set lifecycle configuration
gsutil lifecycle set lifecycle.json gs://cverai

# View lifecycle configuration
gsutil lifecycle get gs://cverai
```

### 7.2 Common Lifecycle Patterns

**Delete old files:**
```json
{
  "lifecycle": {
    "rule": [{
      "action": {"type": "Delete"},
      "condition": {"age": 365}
    }]
  }
}
```

**Move to cheaper storage:**
```json
{
  "lifecycle": {
    "rule": [{
      "action": {"type": "SetStorageClass", "storageClass": "NEARLINE"},
      "condition": {"age": 30}
    }]
  }
}
```

---

## Part 8: Versioning

### 8.1 Enable Versioning

```bash
# Enable versioning
gsutil versioning set on gs://cverai

# Disable versioning
gsutil versioning set off gs://cverai

# Check versioning status
gsutil versioning get gs://cverai
```

### 8.2 Work with Versions

```bash
# List all versions
gsutil ls -a gs://cverai/file.txt

# View specific version
gsutil ls -L gs://cverai/file.txt#1234567890

# Download specific version
gsutil cp gs://cverai/file.txt#1234567890 ./old-version.txt

# Delete specific version
gsutil rm gs://cverai/file.txt#1234567890

# Delete all versions
gsutil rm -a gs://cverai/file.txt
```

---

## Part 9: Signed URLs (Temporary Access)

### 9.1 Generate Signed URLs

```bash
# Create signed URL valid for 1 hour
gsutil signurl -d 1h private-key.json gs://cverai/private-file.pdf

# Create signed URL valid for 7 days
gsutil signurl -d 7d private-key.json gs://cverai/file.txt

# Create signed URL for upload
gsutil signurl -m PUT -d 1h private-key.json gs://cverai/upload.txt
```

**Note:** You need a service account key (JSON file) for this.

---

## Part 10: CORS Configuration

### 10.1 Set CORS Policy

Create cors.json:
```json
[
  {
    "origin": ["https://example.com"],
    "method": ["GET", "POST"],
    "responseHeader": ["Content-Type"],
    "maxAgeSeconds": 3600
  }
]
```

Apply CORS:
```bash
# Set CORS configuration
gsutil cors set cors.json gs://cverai

# View CORS configuration
gsutil cors get gs://cverai
```

---

## Part 11: Monitoring & Usage

### 11.1 Get Bucket Size

```bash
# Get total size of bucket
gsutil du -sh gs://cverai

# Get size of specific folder
gsutil du -sh gs://cverai/documents/

# Get detailed size breakdown
gsutil du -h gs://cverai

# Count objects
gsutil ls -r gs://cverai | wc -l
```

### 11.2 Check Quotas & Limits

```bash
# View project quota
gcloud compute project-info describe --project=cverai

# View storage usage
gcloud alpha billing accounts list
```

---

## Part 12: Advanced Operations

### 12.1 Compose Objects

```bash
# Combine multiple objects into one
gsutil compose gs://cverai/part1.txt gs://cverai/part2.txt gs://cverai/combined.txt
```

### 12.2 Hash Verification

```bash
# Calculate MD5 hash
gsutil hash -m file.txt

# Calculate CRC32C hash
gsutil hash -c file.txt

# Verify integrity after upload
gsutil hash -m file.txt
gsutil stat gs://cverai/file.txt
```

### 12.3 Parallel Operations

```bash
# Enable parallel composite uploads for large files
gsutil -o GSUtil:parallel_composite_upload_threshold=150M cp large-file.zip gs://cverai/

# Set number of parallel threads
gsutil -m -o "GSUtil:parallel_thread_count=16" cp -r large-folder/ gs://cverai/
```

### 12.4 Resumable Uploads

```bash
# Upload with resumable feature (automatic for files > 8MB)
gsutil cp -j text/plain large-file.txt gs://cverai/

# Check resumable upload tracker
ls ~/.gsutil/tracker-files/
```

---

## Part 13: Batch Operations

### 13.1 Batch File Operations

```bash
# Create file list
echo "file1.txt
file2.txt
file3.txt" > files.txt

# Batch upload
cat files.txt | xargs -I {} gsutil cp {} gs://cverai/

# Batch operations with parallel execution
gsutil -m cp -I gs://cverai/ < files.txt
```

### 13.2 Using Scripts

**Bash Script Example:**
```bash
#!/bin/bash
for file in *.jpg; do
    gsutil cp "$file" gs://cverai/images/
    echo "Uploaded $file"
done
```

**PowerShell Script Example:**
```powershell
Get-ChildItem *.jpg | ForEach-Object {
    gsutil cp $_.Name gs://cverai/images/
    Write-Host "Uploaded $($_.Name)"
}
```

---

## Part 14: Notifications

### 14.1 Set Up Pub/Sub Notifications

```bash
# Create notification
gsutil notification create -t TOPIC_NAME -f json gs://cverai

# List notifications
gsutil notification list gs://cverai

# Delete notification
gsutil notification delete gs://cverai#1
```

---

## Part 15: Logging

### 15.1 Enable Logging

```bash
# Enable access logs
gsutil logging set on -b gs://logs-bucket -o AccessLog gs://cverai

# Enable storage logs
gsutil logging set on -b gs://logs-bucket -o StorageLog gs://cverai

# Check logging status
gsutil logging get gs://cverai
```

---

## Part 16: Encryption

### 16.1 Customer-Managed Encryption Keys

```bash
# Upload with encryption key
gsutil -o "GSUtil:encryption_key=YOUR_KEY" cp file.txt gs://cverai/

# Download with encryption key
gsutil -o "GSUtil:encryption_key=YOUR_KEY" cp gs://cverai/file.txt .
```

---

## Part 17: Configuration & Settings

### 17.1 Configure gsutil

```bash
# Open configuration wizard
gsutil config

# Edit config file directly
gsutil config -e

# View current configuration
gsutil config -l

# Set specific config option
gsutil config -o "GSUtil:parallel_thread_count" 16
```

### 17.2 Common Configuration Options

```bash
# Set default project
gcloud config set project cverai

# Set default region
gcloud config set compute/region us-east1

# Set default zone
gcloud config set compute/zone us-east1-b
```

---

## Part 18: Troubleshooting

### 18.1 Debug Mode

```bash
# Run with debug output
gsutil -D cp file.txt gs://cverai/

# Run with detailed debug info
gsutil -DD ls gs://cverai/
```

### 18.2 Check Connection

```bash
# Test authentication
gcloud auth list

# Test access to bucket
gsutil ls gs://cverai

# Verify credentials
gcloud auth application-default print-access-token
```

---

## Part 19: Useful Aliases & Shortcuts

**For PowerShell (add to profile):**
```powershell
# Open with: notepad $PROFILE

function gcs-ls { gsutil ls -lh $args }
function gcs-up { gsutil -m cp -r $args }
function gcs-down { gsutil -m cp -r $args }
function gcs-sync { gsutil rsync -r -d $args }
```

**For Bash (add to .bashrc):**
```bash
alias gcs-ls='gsutil ls -lh'
alias gcs-up='gsutil -m cp -r'
alias gcs-down='gsutil -m cp -r'
alias gcs-sync='gsutil rsync -r -d'
```

---

## Part 20: Best Practices

### Performance Optimization
- Use `-m` flag for parallel operations with multiple files
- Use composite uploads for large files (automatic for >8MB)
- Enable parallel composite uploads for files >150MB
- Use rsync for incremental updates

### Security Best Practices
- Never make buckets public unless necessary
- Use signed URLs for temporary access
- Enable versioning for important data
- Use lifecycle rules to delete old data
- Enable encryption for sensitive data

### Cost Optimization
- Use appropriate storage classes
- Set lifecycle rules to move to cheaper storage
- Delete unnecessary versions
- Use Nearline/Coldline for archives
- Monitor usage regularly

---

## Quick Reference Card

```bash
# Authentication
gcloud auth login
gcloud config set project PROJECT_ID

# Bucket Operations
gsutil ls                              # List buckets
gsutil mb gs://bucket-name             # Create bucket
gsutil rb gs://bucket-name             # Delete bucket
gsutil ls -L -b gs://bucket-name       # Bucket info

# Object Operations
gsutil cp file.txt gs://bucket/        # Upload
gsutil cp gs://bucket/file.txt .       # Download
gsutil ls gs://bucket/                 # List objects
gsutil rm gs://bucket/file.txt         # Delete
gsutil mv gs://bucket/old gs://bucket/new  # Move/Rename

# Sync
gsutil rsync -r ./local gs://bucket/   # Sync local to cloud

# Permissions
gsutil acl ch -u AllUsers:R gs://bucket/file.txt  # Make public
gsutil iam get gs://bucket/            # View permissions

# Metadata
gsutil stat gs://bucket/file.txt       # View metadata
gsutil setmeta -h "Content-Type:text/html" gs://bucket/file.txt

# Advanced
gsutil -m cp -r folder/ gs://bucket/   # Parallel upload
gsutil du -sh gs://bucket/             # Bucket size
gsutil versioning set on gs://bucket/  # Enable versioning
```

---

## Additional Resources

- Official Documentation: https://cloud.google.com/storage/docs
- gsutil Tool Documentation: https://cloud.google.com/storage/docs/gsutil
- gcloud CLI Reference: https://cloud.google.com/sdk/gcloud/reference
- Pricing Calculator: https://cloud.google.com/products/calculator
- Best Practices: https://cloud.google.com/storage/docs/best-practices

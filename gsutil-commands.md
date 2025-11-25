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
gsutil ls -p companyName

**Initialize gcloud:**
```bash
gcloud init
```

Follow the prompts:
1. Login to your Google account (opens browser)
2. Select your project (companyName in your case)
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
gcloud config set project companyName

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
gsutil ls -p companyName
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
gsutil mb -p companyName -c STANDARD -l us-east1 gs://my-bucket
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
gsutil ls -L -b gs://companyName

# Get bucket location
gsutil ls -L -b gs://companyName | grep Location

# Get storage class
gsutil ls -L -b gs://companyName | grep "Storage class"
```

---

## Part 3: Object Operations (Files)

### 3.1 Upload Files

```bash
# Upload single file
gsutil cp myfile.txt gs://companyName/

# Upload to specific folder
gsutil cp myfile.txt gs://companyName/documents/

# Upload multiple files
gsutil cp file1.txt file2.txt gs://companyName/

# Upload entire directory
gsutil cp -r my-folder/ gs://companyName/

# Upload with progress indicator
gsutil -m cp -r my-folder/ gs://companyName/
```

**Upload Options:**
```bash
# Parallel upload (faster for multiple files)
gsutil -m cp *.jpg gs://companyName/images/

# Resume interrupted uploads
gsutil -o GSUtil:parallel_composite_upload_threshold=150M cp large-file.zip gs://companyName/

# Set storage class during upload
gsutil cp -s NEARLINE myfile.txt gs://companyName/

# Set metadata during upload
gsutil -h "Content-Type:text/plain" cp myfile.txt gs://companyName/
```

### 3.2 Download Files

```bash
# Download single file
gsutil cp gs://companyName/myfile.txt .

# Download to specific location
gsutil cp gs://companyName/myfile.txt C:/Downloads/

# Download entire folder
gsutil cp -r gs://companyName/documents/ .

# Download all files matching pattern
gsutil cp gs://companyName/*.jpg ./images/

# Parallel download (faster)
gsutil -m cp -r gs://companyName/large-folder/ .
```

### 3.3 List Files

```bash
# List all objects in bucket
gsutil ls gs://companyName

# List with details
gsutil ls -l gs://companyName

# List with human-readable sizes
gsutil ls -lh gs://companyName

# List recursively (all subdirectories)
gsutil ls -r gs://companyName

# List with full details
gsutil ls -L gs://companyName/myfile.txt

# List with wildcard
gsutil ls gs://companyName/*.pdf
gsutil ls gs://companyName/documents/**/*.txt
```

### CORS SETUP

```bash 
gsutil cors set cors.json gs://companyName
gsutil cors get gs://companyName```

### 3.4 Delete Files

```bash
# Delete single file
gsutil rm gs://companyName/myfile.txt

# Delete parallel, multithread the deletion process.
gsutil -m rm -r gs://companyName/**


# Delete multiple files
gsutil rm gs://companyName/file1.txt gs://companyName/file2.txt

# Delete all files in folder
gsutil rm gs://companyName/old-folder/**

# Delete with wildcard
gsutil rm gs://companyName/*.tmp

# Parallel delete (faster)
gsutil -m rm gs://companyName/large-folder/**
```

### 3.5 Move & Rename Files

```bash
# Move file (rename)
gsutil mv gs://companyName/oldname.txt gs://companyName/newname.txt

# Move to different folder
gsutil mv gs://companyName/file.txt gs://companyName/documents/file.txt

# Move between buckets
gsutil mv gs://old-bucket/file.txt gs://new-bucket/file.txt

# Move entire folder
gsutil mv gs://companyName/old-folder gs://companyName/new-folder
```

### 3.6 Copy Files

```bash
# Copy within same bucket
gsutil cp gs://companyName/file.txt gs://companyName/backup/file.txt

# Copy between buckets
gsutil cp gs://companyName/file.txt gs://other-bucket/

# Copy entire folder
gsutil cp -r gs://companyName/folder/ gs://other-bucket/

# Parallel copy (faster)
gsutil -m cp -r gs://companyName/large-folder/ gs://backup-bucket/
```

---

## Part 4: Synchronization

### 4.1 Sync Local to Cloud

```bash
# Sync local folder to bucket (like rsync)
gsutil rsync -r ./local-folder gs://companyName/remote-folder

# Sync and delete files not in source
gsutil rsync -r -d ./local-folder gs://companyName/remote-folder

# Dry run (preview changes)
gsutil rsync -r -n ./local-folder gs://companyName/remote-folder

# Sync with exclusions
gsutil rsync -r -x ".*\.tmp$|.*\.log$" ./local-folder gs://companyName/
```

### 4.2 Sync Cloud to Local

```bash
# Sync bucket to local folder
gsutil rsync -r gs://companyName/remote-folder ./local-folder

# Two-way sync (use carefully!)
gsutil rsync -r -d ./local-folder gs://companyName/remote-folder
```

---

## Part 5: Permissions & Access Control

### 5.1 Make Files Public

```bash
# Make single file public
gsutil acl ch -u AllUsers:R gs://companyName/public-file.txt

# Make all files in folder public
gsutil -m acl ch -r -u AllUsers:R gs://companyName/public-folder/

# Make entire bucket public
gsutil iam ch allUsers:objectViewer gs://companyName
```

### 5.2 Make Files Private

```bash
# Remove public access from file
gsutil acl ch -d AllUsers gs://companyName/file.txt

# Remove public access from bucket
gsutil iam ch -d allUsers:objectViewer gs://companyName
```

### 5.3 Grant Specific User Access

```bash
# Grant read access to specific user
gsutil acl ch -u user@example.com:R gs://companyName/file.txt

# Grant write access
gsutil acl ch -u user@example.com:W gs://companyName/file.txt

# Grant full control
gsutil acl ch -u user@example.com:O gs://companyName/file.txt
```

### 5.4 View Permissions

```bash
# View bucket IAM policy
gsutil iam get gs://companyName

# View object ACL
gsutil acl get gs://companyName/file.txt

# View bucket ACL
gsutil acl get gs://companyName
```

### 5.5 Set Bucket-Level Permissions

```bash
# Grant storage admin to user
gsutil iam ch user:user@example.com:roles/storage.admin gs://companyName

# Grant object viewer
gsutil iam ch user:user@example.com:roles/storage.objectViewer gs://companyName

# Grant object creator
gsutil iam ch user:user@example.com:roles/storage.objectCreator gs://companyName
```

---

## Part 6: Metadata & Properties

### 6.1 View Metadata

```bash
# View object metadata
gsutil stat gs://companyName/myfile.txt

# View with full details
gsutil ls -L gs://companyName/myfile.txt
```

### 6.2 Set Metadata

```bash
# Set Content-Type
gsutil setmeta -h "Content-Type:text/html" gs://companyName/file.html

# Set Cache-Control
gsutil setmeta -h "Cache-Control:public, max-age=3600" gs://companyName/file.js

# Set custom metadata
gsutil setmeta -h "x-goog-meta-author:John Doe" gs://companyName/file.txt

# Set multiple headers
gsutil setmeta -h "Content-Type:image/jpeg" -h "Cache-Control:max-age=86400" gs://companyName/image.jpg
```

### 6.3 Set Storage Class

```bash
# Change storage class of object
gsutil rewrite -s NEARLINE gs://companyName/archive-file.txt

# Change for all objects in folder
gsutil -m rewrite -s COLDLINE gs://companyName/old-data/**

# Change bucket default storage class
gsutil defstorageclass set NEARLINE gs://companyName
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
gsutil lifecycle set lifecycle.json gs://companyName

# View lifecycle configuration
gsutil lifecycle get gs://companyName
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
gsutil versioning set on gs://companyName

# Disable versioning
gsutil versioning set off gs://companyName

# Check versioning status
gsutil versioning get gs://companyName
```

### 8.2 Work with Versions

```bash
# List all versions
gsutil ls -a gs://companyName/file.txt

# View specific version
gsutil ls -L gs://companyName/file.txt#1234567890

# Download specific version
gsutil cp gs://companyName/file.txt#1234567890 ./old-version.txt

# Delete specific version
gsutil rm gs://companyName/file.txt#1234567890

# Delete all versions
gsutil rm -a gs://companyName/file.txt
```

---

## Part 9: Signed URLs (Temporary Access)

### 9.1 Generate Signed URLs

```bash
# Create signed URL valid for 1 hour
gsutil signurl -d 1h private-key.json gs://companyName/private-file.pdf

# Create signed URL valid for 7 days
gsutil signurl -d 7d private-key.json gs://companyName/file.txt

# Create signed URL for upload
gsutil signurl -m PUT -d 1h private-key.json gs://companyName/upload.txt
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
gsutil cors set cors.json gs://companyName

# View CORS configuration
gsutil cors get gs://companyName
```

---

## Part 11: Monitoring & Usage

### 11.1 Get Bucket Size

```bash
# Get total size of bucket
gsutil du -sh gs://companyName

# Get size of specific folder
gsutil du -sh gs://companyName/documents/

# Get detailed size breakdown
gsutil du -h gs://companyName

# Count objects
gsutil ls -r gs://companyName | wc -l
```

### 11.2 Check Quotas & Limits

```bash
# View project quota
gcloud compute project-info describe --project=companyName

# View storage usage
gcloud alpha billing accounts list
```

---

## Part 12: Advanced Operations

### 12.1 Compose Objects

```bash
# Combine multiple objects into one
gsutil compose gs://companyName/part1.txt gs://companyName/part2.txt gs://companyName/combined.txt
```

### 12.2 Hash Verification

```bash
# Calculate MD5 hash
gsutil hash -m file.txt

# Calculate CRC32C hash
gsutil hash -c file.txt

# Verify integrity after upload
gsutil hash -m file.txt
gsutil stat gs://companyName/file.txt
```

### 12.3 Parallel Operations

```bash
# Enable parallel composite uploads for large files
gsutil -o GSUtil:parallel_composite_upload_threshold=150M cp large-file.zip gs://companyName/

# Set number of parallel threads
gsutil -m -o "GSUtil:parallel_thread_count=16" cp -r large-folder/ gs://companyName/
```

### 12.4 Resumable Uploads

```bash
# Upload with resumable feature (automatic for files > 8MB)
gsutil cp -j text/plain large-file.txt gs://companyName/

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
cat files.txt | xargs -I {} gsutil cp {} gs://companyName/

# Batch operations with parallel execution
gsutil -m cp -I gs://companyName/ < files.txt
```

### 13.2 Using Scripts

**Bash Script Example:**
```bash
#!/bin/bash
for file in *.jpg; do
    gsutil cp "$file" gs://companyName/images/
    echo "Uploaded $file"
done
```

**PowerShell Script Example:**
```powershell
Get-ChildItem *.jpg | ForEach-Object {
    gsutil cp $_.Name gs://companyName/images/
    Write-Host "Uploaded $($_.Name)"
}
```

---

## Part 14: Notifications

### 14.1 Set Up Pub/Sub Notifications

```bash
# Create notification
gsutil notification create -t TOPIC_NAME -f json gs://companyName

# List notifications
gsutil notification list gs://companyName

# Delete notification
gsutil notification delete gs://companyName#1
```

---

## Part 15: Logging

### 15.1 Enable Logging

```bash
# Enable access logs
gsutil logging set on -b gs://logs-bucket -o AccessLog gs://companyName

# Enable storage logs
gsutil logging set on -b gs://logs-bucket -o StorageLog gs://companyName

# Check logging status
gsutil logging get gs://companyName
```

---

## Part 16: Encryption

### 16.1 Customer-Managed Encryption Keys

```bash
# Upload with encryption key
gsutil -o "GSUtil:encryption_key=YOUR_KEY" cp file.txt gs://companyName/

# Download with encryption key
gsutil -o "GSUtil:encryption_key=YOUR_KEY" cp gs://companyName/file.txt .
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
gcloud config set project companyName

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
gsutil -D cp file.txt gs://companyName/

# Run with detailed debug info
gsutil -DD ls gs://companyName/
```

### 18.2 Check Connection

```bash
# Test authentication
gcloud auth list

# Test access to bucket
gsutil ls gs://companyName

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

# 1. About

This solution is designed to allow users to automatically snapshot and back up specified Mongo Database from their local machine to an AWS S3 Bucket.

The AWS stacks are automatically created. 
An example configuration for AWS is included.
All databases backed up in AWS are encrypted.
Databases are only backed up when they have been altered.

## 1.1. On going tasks

- Install AWS CLI
- S3 bucket template
- deploy scripts
- python for getting files
- download and restore script
- Billing alarms
 
## 1.2. Intended Use

Storing copies of data used for local development / model training / data mining, offsite cheaply and easily.

# 2. Assumptions

- Linux Environment
- Python Installed
- Cron Installed
- AWS SDK Installed and Profile created

# 3. Cron

## 3.1. Installing Cron

Almost every Linux distribution has some form of cron installed by default. However, if you’re using an Ubuntu machine on which cron isn’t installed, you can install it using APT.

Before installing cron on an Ubuntu machine, update the computer’s local package index:
```
    sudo apt update
```

Then install cron with the following command:
```
    sudo apt install cron
```

You’ll need to make sure it’s set to run in the background too:
```
    sudo systemctl enable cron
```

## 3.2. Configuring Cron

```
    crontab -e
```

Then just add something as follows:

```
    # Mongo Export to AWS everyday at 1AM
    0 1 * * * /path/to/script.sh
```

Examples of how to write cron tab schedule expressions can be found here:

https://crontab.guru/every-day-at-1am


Project Title:

Automated user migration and management of AWS Identity and Access Management (IAM) resources

Project Description:

In this project based on a real-world scenario, I acted as Cloud Specialist with the mission to migrate users using automation while using manage AWS IAM (Identity and Access Management) resources.

There were 100 users that needed to be migrated and have MFA (Multi-factor authentication) enabled on their accounts, as this is a security best practice.

To avoid repetitive and manual tasks in the AWS console, I needed to think about automating the processes.

Using VSCode with the AWS CLI and Shell scripts, I was able to automate and create users, user groups, and policies with the press of a button.

Part 1: Creating User Groups

In this project, we’re going to first create four user groups named CloudAdmin (for Cloud Architects), DBA (Database Admins), LinuxAdmin (Linux Admins), and NetworkAdmin (Network Admins).

It is easy to create a user group through IAM. Open IAM > User groups (under Access management), then click on ‘Create group’

Here, we can enter a name for the group (User group name), add users to the group, and policies as well. After that, scroll down and Create user group.

We can do that for each of the four groups, but we can also automate their creation.

The Create-Groups-with-Policy.sh bash script can create all four user groups with the corresponding policies they need.

As long as there’s a connection between AWS and VSCode, that script can be run and the groups will be created with the corresponding policies.

X:XX in the video below explains what the code does

Part 2: Allowing Users to Change their Password

In AWS, we can also add policies manually to user groups by staying in IAM, clicking on User groups, and clicking on a particular group.

Then click on Permissions and on the right, click on Add permissions, then Attach policies

Start searching for IAMUserChangePassword and attach the policy

As we see, it is added, but it can also be automated

The  script will add the IAMUserChangePassword policy to each group. All that would need to be entered is the Account ID. Paste the code into VSCode and it will add the policy to each group.

Part 3: Creating Users

We know by now how to create users manually, so we’ll go straight to the automation.

Download the  Excel file. We mentioned 100 users in the description, but we’ll only create 5 for ease of cleanup after the lab.

Delete the cells from row 6 to 101 (actually delete the cells by right clicking and selecting Delete, don’t just press the Delete key)

Delete the Name column

Do CTRL + F, click on the Replace tab, type ‘@abc-company.com’ in ‘Find what’ and leave ‘Replace with’ blank. Click on Replace All to remove the email domain.

Rename Email to User, Rename Team to Group, add a column header named ‘password’ and set every password to every user to ‘ChangeMe123456!’

Rename each group to correspond to the names of the groups on User groups on IAM

Cloud Architect -> CloudAdmin

Database Admin -> DBA

Linux Admin -> LinuxAdmin

Network Admin -> NetworkAdmin

Download the  file, the changes done above should look like this CSV, the Excel file can then be saved as a csv, or you can opt to use this one.

Inside the AWS CloudShell, run a couple of commands

sudo yum install dos2unix -y

This is the prerequisite to the script that will automate adding users

wget 

This is the script that CloudShell downloads from an S3 bucket which we’ll use to automate adding users

ls -la

Check to see the files in the directory

The aws-iam-create-user.sh script is what we’re looking for, although it was already installed.

The original permissions were -rw-r—r-- which means we have to set it up as an executable

The command below will make the script executable

chmod +x aws-iam-create-user.sh

Doing ls -la again should reflect the permissions as -rwxr-xr-x

In the CloudShell, upload users2.csv from your PC, then it should appear when typing ‘ls -la’

https://i.imgur.com/DqmT9Xj.png

To start the script, type the line below into the console:

./aws-iam-create-user.sh users2.csv

The script will automate adding users to IAM, with their assigned groups

Returning to Users within IAM should show the users that were just created (May take a refresh)

Open an Incognito window, and login to one of the created users. It will prompt the user you login with to change their password upon first login.

Part 4: Creating MFA Policy, Enabling MFA

Multifactor authentication is important for when a user has their account credentials compromised so that a threat actor cannot gain full access to an account even if they have the user’s password. They would also need the marker of MFA in order to get in as well, which usually should be on the physical of the actual user.

AWS also has this feature, but it should also be added through policies.

In order to create the MFA policy, navigate to Policies within IAM and click on ‘Create policy.’

Click on the JSON button next to Visual and paste the contents of  into the Policy editor.

https://i.imgur.com/blFfAod.png

Click Next, then give the Policy a name, which will be ‘EnforceMFAPolicy’ then create the Policy

Like before, we will use the shell script to add this policy to every group with . Run that code and verify every user group has the new policy.

Open a different Incognito window and login to one of the other users. Once in, it’ll prompt that user again to change their password. Consult the CSV file and add a @ to the end of the new password to make it easy.

Click on the user’s name on the top right and click on ‘Security credentials’

Here we can add MFA

Name the ‘Device name’ anything you want and select the MFA device. We’ll use ‘Authenticator app’ for this. Then click Next.

Upon clicking Next, choose the type of authenticator app you want to use, here we’re using Google Authenticator. Reveal the QR code, and scan it using the app. Two consecutive MFA codes will have to be entered to setup MFA.

When done, click on Add MFA.

To check to see if MFA is in effect, log off and log back onto the user and enter the MFA code upon relogin. After it is entered, it will complete the login.

![Image](media/image3.png)

![Image](media/image5.png)

![Image](media/image11.png)

![Image](media/image18.png)

![Image](media/image8.png)

![Image](media/image20.png)

![Image](media/image7.png)

![Image](media/image15.png)

![Image](media/image13.png)

![Image](media/image19.png)

![Image](media/image2.png)

![Image](media/image4.png)

![Image](media/image10.png)

![Image](media/image17.png)

![Image](media/image1.png)

![Image](media/image6.png)

![Image](media/image9.png)

![Image](media/image14.png)

![Image](media/image12.png)

![Image](media/image16.png)
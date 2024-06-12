# Automated User Migration and Management of AWS Identity and Access Management (IAM) Resources

## Project Description
In this project based on a real-world scenario, I acted as a Cloud Specialist with the mission to migrate users using automation while managing AWS IAM resources.

There were 100 users that needed to be migrated and have MFA (Multi-factor authentication) enabled on their accounts as this is a security best practice.

To avoid repetitive and manual tasks in the AWS console, I automated the processes using VSCode with the AWS CLI and Shell scripts to create users, user groups, and policies with the press of a button.

## Part 1: Creating User Groups
In this project, we’re going to first create four user groups named CloudAdmin (for Cloud Architects), DBA (Database Admins), LinuxAdmin (Linux Admins), and NetworkAdmin (Network Admins).

It is easy to create a user group through IAM. Open IAM > User groups (under Access management) then click on ‘Create group’

![Create Group](https://i.imgur.com/wnGihoZ.png)

Here we can enter a name for the group (User group name), add users to the group and policies as well. After that, scroll down and Create user group.

We can do that for each of the four groups, but we can also automate their creation.
The `Create-Groups-with-Policy.sh` bash script can create all four user groups with the corresponding policies they need.

### Create-Groups-with-Policy.sh
As long as there’s a connection between AWS and VSCode, that script can be run and the groups will be created with the corresponding policies.

## Part 2: Allowing Users to Change their Password
In AWS, we can also add policies manually to user groups by staying in IAM, clicking on User groups, and clicking on a particular group.

![User Group](https://i.imgur.com/47rAE8V.png)

Then click on Permissions and on the right click on Add permissions then Attach policies

![Attach Policies](https://i.imgur.com/TIChBiZ.png)

Start searching for `IAMUserChangePassword` and attach the policy

![IAM User Change Password](https://i.imgur.com/JHcoamx.png)

As we see it is added but it can also be automated

![Automate Policy](https://i.imgur.com/a4VDVqC.png)

The `Add-IAMUserChangePassword.sh` script will add the `IAMUserChangePassword` policy to each group. All that would need to be entered is the Account ID. Paste the code into VSCode and it will add the policy to each group.

## Part 3: Creating Users
We know by now how to create users manually, so we’ll go straight to the automation.

Download the `IT_Team_ABCCompany-211113-015614.xlsx` Excel file. We mentioned 100 users in the description, but we’ll only create 5 for ease of cleanup after the lab.

1. Delete the cells from row 6 to 101 (actually delete the cells by right-clicking and selecting Delete, don’t just press the Delete key).
2. Delete the Name column.
3. Do `CTRL + F`, click on the Replace tab, type `@abc-company.com` in ‘Find what’ and leave ‘Replace with’ blank. Click on Replace All to remove the email domain.
4. Rename Email to User, Rename Team to Group, add a column header named ‘password’ and set every password to every user to `ChangeMe123456!`.
5. Rename each group to correspond to the names of the groups on User groups on IAM:
    - Cloud Architect -> CloudAdmin
    - Database Admin -> DBA
    - Linux Admin -> LinuxAdmin
    - Network Admin -> NetworkAdmin

Download the `users2.csv` file. The changes done above should look like this CSV. The Excel file can then be saved as a CSV or you can opt to use this one.

Inside the AWS CloudShell, run a couple of commands:

```sh
sudo yum install dos2unix -y

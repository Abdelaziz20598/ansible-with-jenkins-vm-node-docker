#! /bin/bash


#check if the file path passed as a parameter
if [ -z "$1" ]; then
	echo "please provide a file"
	exit 1
fi

#save the file in file variable
file="$1"

#check if the file path exist
if [ ! -f "$file" ]; then
	echo "The file not found!"
	exit 1
fi
#generating keys and naming it ansible , the key name must same to the username of the remote server
ssh-keygen -t rsa -b 4096 -f ~/.ssh/abdelaziz


#number of lines == number of users i want to ssh into it
#By redirecting the input with < "$file", you avoid having wc output the filename along with the line count. 
#number_lines=$(wc -l < "$file")
echo "waiting to copy the id to the server "
sleep 2
echo "still waiting"
#while loop for each line of the file as each line contain one user:host
# If your txt file has no newline at the end, read won't handle the last line properly.
#read treats the input as a line, and if there is no newline (\n) after the last line, the loop doesn't process it correctly. In a typical shell, read requires a newline at the end of the file or line to trigger the reading
#The || [ -n "$line" ] part ensures that the last line is read even if it doesn't end with a newline.
while IFS= read -r line || [ -n "$line" ]; do 
    echo "Original line: $line"
	#/:/@/g is a sed expression that replaces every occurrence of : with @ on each line. The g at the end stands for "global," meaning all occurrences of : will be replaced, not just the first one.
	modified_line=$(echo "$line" | sed 's/:/@/g')
	#gsub(/:/, "@") is an awk function that globally substitutes all colons (:) with the at symbol (@) in each line.
	#modified_line=$(echo "$line" | awk '{gsub(/:/, "@"); print}')
	echo "This is the host you want to connect:"
	echo "Modified line: $modified_line"
	#ansible user most be exist in the server before running ssh, i will ssh to it so it must be created first
	# echo "$modified_line" >> new_hosts.txt
    # 	#grep -q "^ansible:" /etc/passwd
    # 	id ansible &>/dev/null
    # 	if [ $? -ne 0 ]; then
    # 		useradd -m ansible
    # 		echo "ansible:12345" | chpasswd
    # 		usermod -aG sudo ansible
    # 	fi
    		
    ssh "$modified_line"
    # Copy the SSH public key to the remote server (user@host)
    ssh-copy-id -i ~/.ssh/abdelaziz.pub "$modified_line"
    # Attempt to copy the SSH public key to the remote server
    if ! ssh-copy-id -i ~/.ssh/abdelaziz.pub "$modified_line"; then
        echo "Failed to copy SSH key to $modified_line"
    else
        echo "Successfully copied SSH key to $modified_line"
    fi
done < "$file"

# After copying the keys, SSH into the first user/host combination
first_line=$(head -n 1 "$file")
modified_first_line=$(echo "$first_line" | sed 's/:/@/g')

# SSH into the first user@host
# echo "SSH into the first user@host: $modified_first_line"
# ssh "$modified_first_line"

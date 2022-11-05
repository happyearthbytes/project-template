IN=initial-test-data.txt
echo "" > blank.txt
mkdir -p results
xxd -ps -g1 -c40 -r $IN > out
/usr/local/opt/openssl½¾1.1/bin/openssl enc -aes-256-cbc -d -pbkdf2 -in out -out temp.tar -pass file:blank.txt
tar -xf temp.tar -C results
ls results

# git@github.com:happyearthbytes/project-template.git
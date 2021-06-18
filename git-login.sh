# Login to Gitub

dotfile_dir=$CWD
declare -a files=("id_rsa.pub" "id_ecdsa.pub" "id_ed25519.pub")
ssh_key_exists=false

cd ~/.ssh/
for FILE in ${files}; do
  if [[ -f $FILE ]]
  then
    echo "The file ${FILE} exists!"
    ssh_key_exists=true
  fi
done

cd $dotfile_dir

echo "$ssh_key_exists"
if [[ ! "$ssh_key_exists" ]]; then
  echo "Generating new ssh key..."
fi

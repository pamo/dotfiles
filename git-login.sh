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

echo "SSH KEY Exists: $ssh_key_exists"

if [[ ! "$ssh_key_exists" ]]; then
  echo "Generating new ssh key..."
  ssh-keygen -t ed25519 -C "pamela.ocampo@gmail.com"
  echo "Starting ssh-agent"
  eval "$(ssh-agent -s)"
  echo "Copying over config file"
  cp ssh-config ${HOME}/config
  cat ${HOME}/.ssh/config
  ssh-add -K ${HOME}/id_ed25519
fi

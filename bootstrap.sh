if ! [ -f "~/.bootstrap.ready" ]; then
cd /mnt/repos/
git clone https://github.com/Tiendil/the-tale.git
git clone https://github.com/Tiendil/deworld.git
git clone https://github.com/Tiendil/dext.git
git clone https://github.com/Tiendil/questgen.git

DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
DEBIAN_FRONTEND=noninteractive add-apt-repository -y universe
DEBIAN_FRONTEND=noninteractive apt-get -y update
DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential libssl-dev libffi-dev python-dev ruby software-properties-common python-pip

cd /mnt/repos/the-tale/deploy

pip install ansible
ansible-galaxy install -r requirements.yml
mkdir /etc/ansible
echo "local.the-tale" > /etc/ansible/hosts

ansible-playbook --extra-vars "@provisioning/develop_variables.yml" --connection=local provisioning/game_server.yml

head -n45 /etc/nginx/sites-enabled/the_tale.conf  > the_tale.conf
echo "
        location /static {
                root /var/www/the_tale;
                try_files \$uri \$uri/ 404;
        }
" >> the_tale.conf
tail -n114 /etc/nginx/sites-enabled/the_tale.conf  >> the_tale.conf
cp the_tale.conf /etc/nginx/sites-enabled/
service nginx restart

touch ~/.bootstrap.ready

fi

supervisorctl start all
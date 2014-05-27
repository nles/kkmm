#!/usr/bin/env bash

apt-get update
# common
apt-get install -y software-properties-common python-software-properties curl
# ruby
apt-get install -y build-essential libxslt1-dev libxml2-dev
\curl -sSL https://get.rvm.io | sudo bash -s stable --ruby=2.1.2
source /usr/local/rvm/scripts/rvm
usermod -a -G rvm vagrant
# node
sudo add-apt-repository -y ppa:chris-lea/node.js
apt-get update
apt-get install -y python-software-properties python g++ make nodejs
npm config set registry http://registry.npmjs.org/
# tools
apt-get install -y git vim
git config --global color.ui auto
mv /root/.gitconfig /home/vagrant/.gitconfig
chown vagrant:vagrant /home/vagrant/.gitconfig

# for middleman
gem install bundler
gem install middleman
npm install -g bower

# shaping the directory structure
mkdir /home/vagrant/.middleman
git clone git://github.com/axyz/middleman-zurb-foundation.git /home/vagrant/.middleman/zurb-foundation
if [ ! -d "/vagrant/templates/kk-annual-report" ]; then
  git clone git://github.com/nles/kk-annual-report.git /vagrant/templates/kk-annual-report
  # muista fork!
  # git clone git://github.com/xyz/kk-annual-report.git /vagrant/templates/kk-annual-report
  chown vagrant:vagrant /vagrant/templates/kk-annual-report -R
fi
ln -s /vagrant/templates/kk-annual-report /home/vagrant/.middleman/kk-annual-report

printf "\n\ncd /vagrant" >> /home/vagrant/.bashrc
#middleman init my_new_project --template=zurb-foundation
echo "Create first site in sites directory with:"
echo 'SITENAME="new_site"; middleman init $SITENAME --template=kk-annual-report && cd $SITENAME && bundle install && bower install && middleman --force-polling'

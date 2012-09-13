# Update, upgrade and install development tools:
apt-get update
apt-get -y upgrade
apt-get -y install build-essential
apt-get -y install git-core

# Install rbenv
git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv

# Add rbenv to the path:
echo '# rbenv setup' > /etc/profile.d/rbenv.sh
echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

chmod +x /etc/profile.d/rbenv.sh
source /etc/profile.d/rbenv.sh

# Install ruby-build:
pushd /tmp
  git clone git://github.com/sstephenson/ruby-build.git
  cd ruby-build
  ./install.sh
popd

# Install Ruby 1.9.2-p290:
rbenv install 1.9.2-p290
rbenv global 1.9.2-p290

# Rehash:
rbenv rehash
# Update, upgrade and install development tools:
apt-get update
apt-get -y upgrade
apt-get -y install build-essential
apt-get -y install git-core

# Install rbenv:
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv

# Add rbenv to the path:
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> .bash_profile
echo 'eval "$(rbenv init -)"' >> .bash_profile
source ~/.bash_profile

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
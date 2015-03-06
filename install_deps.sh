#!/usr/bin/env bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Lein install
sudo -v
wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
mv lein /usr/local/bin
chmod a+x /usr/local/bin/lein

# Anaconda install
http://09c8d0b2229f813c1b93-c95ac804525aac4b6dba79b00b39d1d3.r79.cf1.rackcdn.com/Anaconda-2.1.0-MacOSX-x86_64.sh
bash Anaconda-2.1.0-MacOSX-x86_64.sh

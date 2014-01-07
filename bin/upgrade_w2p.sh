#!/usr/bin/env bash

cd /var/www
sudo mv web2py web2py.old
sudo wget http://mdp.cti.depaul.edu/examples/static/web2py_src.zip
sudo tar xzf web2py_src.zip
cd /var/www/web2py
sudo python web2py.py --upgrade yes
cd /var/www
sudo cp -R web2py.old/applications web2py/.
sudo chgrp -R www /var/www/web2py/applications/
sudo chmod -R g+w /var/www/web2py/applications/

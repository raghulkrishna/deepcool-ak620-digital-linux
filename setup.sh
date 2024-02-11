#!/bin/bash

sudo cp -rf deepcool-ak620-digital.service /lib/systemd/system/
sudo cp -rf deepcool-ak620-digital-restart.service /lib/systemd/system/
sudo cp -rf deepcool-ak620-digital.py /usr/bin/deepcool-ak620-digital.py
sudo systemctl enable deepcool-ak620-digital.service
sudo systemctl enable deepcool-ak620-digital-restart.service
sudo systemctl start deepcool-ak620-digital.service
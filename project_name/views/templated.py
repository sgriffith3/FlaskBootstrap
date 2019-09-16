#!/usr/bin/env python
# -*- coding: UTF-8 -*-
import logging
import subprocess
from flask import render_template, Blueprint

from <project_name>.config import config


blueprint = Blueprint('templated', __name__, template_folder='templates')

log = logging.getLogger('NodifyerAPI')


@blueprint.route('/')
@blueprint.route('/info')
def return_info():
    # Gathers info of VMs
    output = subprocess.check_output('ps aux | grep qemu-system', shell=True)
    output = output.decode('utf-8')
    output = output.split('\n')
    node = {}
    for item in output:
        vm_name, cpus, mem = 'vm_name', '0', '0'
        if "file=" in item:
            image = item.find("file=") + 5
            image = item[image:image+40].split("/")
            vm_name = image[-1].split(',')[0]
        if "cpus=" in item:
            cpu = item.find("cpus=") + 5
            cpus = item[cpu]
        if "-m " in item:
            mem = item.find("-m ") + 3
            mem = item[mem:mem+4]
        vm = {vm_name: {"cores": cpus, "memory": mem}}
        node.update(vm)
    return node


@blueprint.route('/images')
def return_image_ls():
    image_list = subprocess.check_output(['ls', '/var/qemu/images']).split('\n')
    image_dict = {'id': 0}
    count = 1
    for x in (image_list):
        image_dict.update({count: x})
        count += 1
        
    return image_dict
        

# coding: utf-8
# Cookbook:: spython
# Attributes:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['spython']['2']['pip_packages'] = {}
default['spython']['2']['pip_bin'] = 'pip2'
default['spython']['2']['pip_upgrade'] = false
default['spython']['2']['setuptools_upgrade'] = false
default['spython']['2']['packages'] = value_for_platform(
  'debian' => { 'default' => %w(python2.7 python2.7-dev python-pip python-virtualenv) },
  'arch' => { 'default' => %w(python2 python2-pip python2-virtualenv) },
  'freebsd' => { 'default' => %w(python27 py27-pip py27-virtualenv) },
  'centos' => { 'default' => %w(python python-devel python-pip python-virtualenv) },
  'fedora' => { 'default' => %w(python python-devel python-pip python-virtualenv) },
  'suse' => { 'default' => %w(python python-devel python-pip python-virtualenv) },
  'ubuntu' => { '<= 16.04' => %w(python python-dev python-pip python-virtualenv) },
  'default' => %w(python2 python2-dev python2-pip python2-virtualenv)
)

default['spython']['3']['pip_packages'] = {}
default['spython']['3']['pip_bin'] = 'pip3'
default['spython']['3']['pip_upgrade'] = false
default['spython']['3']['setuptools_upgrade'] = false
default['spython']['3']['packages'] = value_for_platform(
  'arch' => { 'default' => %w(python python-pip python-virtualenv) },
  'freebsd' => { 'default' => %w(python36 py36-pip py36-virtualenv) },
  'centos' => { 'default' => %w(python3 python3-devel python3-pip python3-virtualenv) },
  'fedora' => { 'default' => %w(python3 python3-devel python3-pip python3-virtualenv) },
  'suse' => { 'default' => %w(python3 python3-devel python3-pip python3-virtualenv) },
  'default' => %w(python3 python3-dev python3-pip python3-virtualenv)
)

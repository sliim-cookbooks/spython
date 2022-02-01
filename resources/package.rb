# Cookbook:: spython
# Resource:: package
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

unified_mode true
resource_name :spython_package
provides :spython_package
default_action :install

property :runtime, String, default: '3'
property :version, String, default: ''
property :venv, String, default: ''

action :install do
  pip = spython_pip_data(new_resource.runtime)['packages']
  name = new_resource.name
  version = new_resource.version
  fullversion = !version.empty? && version.match(/^[0-9]/) ? "==#{version}" : version

  spython_pip "install #{name}#{fullversion}" do
    runtime new_resource.runtime
    venv new_resource.venv
    # FIXME: support when venv not empty
    not_if { (version.empty? && pip.key?(name)) || (!version.empty? && pip.key?(name) && version == pip[name]['version']) }
  end
end

action :upgrade do
  pip = spython_pip_data(new_resource.runtime)['packages']
  name = new_resource.name
  version = new_resource.version
  fullversion = !version.empty? && version.match(/^[0-9]/) ? "==#{version}" : version

  spython_pip "install --upgrade #{name}#{fullversion}" do
    runtime new_resource.runtime
    venv new_resource.venv
    not_if { (!version.empty? && pip.key?(name) && version == pip[name]['version']) }
  end
end

action :remove do
  pip = spython_pip_data(new_resource.runtime)['packages']
  spython_pip "uninstall #{new_resource.name}" do
    runtime new_resource.runtime
    venv new_resource.venv
    only_if { pip.key?(new_resource.name) }
  end
end

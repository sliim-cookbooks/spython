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

resource_name :spython_package
provides :spython_package
default_action :install

property :runtime, String, default: '3'
property :version, String, default: ''

action :install do
  py = spython_attributes(new_resource.runtime)

  install_cmd = "#{node['pip'][new_resource.runtime.to_s]['bin']} install #{new_resource.name}"
  unless new_resource.version.empty?
    install_cmd << "==#{new_resource.version}"
  end

  execute install_cmd do
    not_if { (new_resource.version.empty? && node['pip'][new_resource.runtime.to_s]['packages'][new_resource.name]) || (!new_resource.version.empty? && node['pip'][new_resource.runtime.to_s]['packages'].key?(new_resource.name) && new_resource.version == node['pip'][new_resource.runtime.to_s]['packages'][new_resource.name]['version']) }
  end
end

action :upgrade do
  py = spython_attributes(new_resource.runtime)

  install_cmd = "#{node['pip'][new_resource.runtime.to_s]['bin']} install --upgrade #{new_resource.name}"
  unless new_resource.version.empty?
    install_cmd << "==#{new_resource.version}"
  end

  execute install_cmd do
    not_if { (!new_resource.version.empty? && node['pip'][new_resource.runtime.to_s]['packages'].key?(new_resource.name) && new_resource.version == node['pip'][new_resource.runtime.to_s]['packages'][new_resource.name]['version']) }
  end
end

action :remove do
  py = spython_attributes(new_resource.runtime)

  execute "#{node['pip'][new_resource.runtime.to_s]['bin']} uninstall #{new_resource.name}" do
    only_if { node['pip'][new_resource.runtime.to_s]['packages'].key?(new_resource.name) }
  end
end

# Cookbook:: spython
# Resource:: runtime
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
resource_name :spython_runtime
provides :spython_runtime
default_action :install

property :version, String, name_property: true

action :install do
  version = new_resource.version
  py = spython_attributes(version)

  ohai 'spython-pip' do
    action :nothing
    plugin 'pip'
  end

  py['packages'].each do |pkg|
    package pkg do
      notifies :reload, 'ohai[spython-pip]', :immediately
    end
  end

  pip = spython_pip_data(version)

  %w(pip setuptools).each do |package|
    upgrade = py["#{package}_upgrade"]
    execute "spython[#{version}]-#{package}-upgrade" do
      action :run
      command "#{pip['bin']} install -U #{package}#{upgrade.is_a?(String) ? upgrade : ''} --index-url=https://pypi.python.org/simple"
      only_if { upgrade }
      ignore_failure true
    end
  end
end

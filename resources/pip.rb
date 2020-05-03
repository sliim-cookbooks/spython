# Cookbook:: spython
# Resource:: pip
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

# TODO: spython_pip resource
resource_name :spython_pip
provides :spython_pip
default_action :run

property :command, String, name_property: true
property :runtime, String, default: '3'
property :cwd, String, default: ''
property :env, Hash, default: {}
property :live_stream, [true, false], default: false
property :returns, [Integer, Array], default: 0
property :timeout, [Integer, Float], default: 3600
property :user, String, default: 'root'
property :group, String, default: 'root'
property :venv, String, default: ''

action :run do
  if new_resource.venv.empty?
    cmd = "pip#{new_resource.runtime}"
  else
    cmd = spython_venv_command(new_resource.venv, new_resource, 'pip')
  end

  execute "#{cmd} #{new_resource.command}" do
    cwd new_resource.cwd unless new_resource.cwd.empty?
    environment new_resource.env
    live_stream new_resource.live_stream
    returns new_resource.returns
    timeout new_resource.timeout
    user new_resource.user
    group new_resource.group
  end
end

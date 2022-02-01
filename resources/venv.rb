# Cookbook:: spython
# Resource:: venv
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
resource_name :spython_venv
provides :spython_venv
default_action :create

property :path, String, name_property: true
property :runtime, String, default: '3'
property :user, String, default: 'root'
property :group, String, default: 'root'

action :create do
  spython_exec "-m virtualenv --python=#{spython_runtime_data(new_resource.runtime)[:bin]} #{new_resource.path}" do
    runtime new_resource.runtime
    user new_resource.user
    group new_resource.group
  end
end

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

property :runtime, String, name_property: true

action :install do
  runtime = new_resource.runtime
  py = spython_attributes(runtime)

  py['packages'].each do |pkg|
    package pkg do
      ['pip', "languages/python#{runtime}"].each do |plugin|
        notifies :reload, "ohai[plugin-#{plugin}]", :immediately
      end
    end
  end

  %w(pip setuptools).each do |package|
    upgrade = py["#{package}_upgrade"]
    spython_package "pip#{runtime}-#{package}" do
      action :upgrade
      runtime runtime
      package package
      version upgrade unless !!upgrade == upgrade
      ignore_failure true
      not_if { !upgrade }
    end
  end
end

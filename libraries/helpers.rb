# Cookbook:: spython
# Library:: helpers
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

def spython_attributes(version)
  raise "Python version #{version} not supported! Supported versions: #{node['spython'].keys}" unless node['spython'].key?(version)
  node['spython'][version]
end

def spython_install(python)
  spython_runtime python.to_s
  node['spython'][python.to_s]['pip_packages'].each do |pkg, ver|
    spython_package pkg do
      runtime python.to_s
      version ver.to_s
    end
  end
end

def spython_venv_command(name, resource, bin = 'python')
  venv = find_resource!(:spython_venv, name)
  raise "The virtualenv #{venv.name} has been created with python #{venv.runtime}. The new resource use python #{resource.runtime}" unless venv.runtime == resource.runtime
  "source #{venv.path}/bin/activate && #{bin}"
end

def spython_pip_data(runtime)
  pip = node['pip'][runtime.to_s]
  raise "No pip binary found for python#{runtime}" unless pip && pip['bin']
  pip
end

def spython_runtime_data(runtime)
  python = node['languages']["python#{runtime}"]
  raise "No python data found for python#{runtime}" unless python && python['bin']
  python
end

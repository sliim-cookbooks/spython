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

def spython_attributes(runtime)
  raise "Python runtime #{runtime} not supported! Supported runtime: #{node['spython'].keys}" unless node['spython'].key?(runtime)
  node['spython'][runtime]
end

def spython_install(runtime)
  spython_runtime runtime
  node['spython'][runtime]['pip_packages'].each do |pkg, ver|
    spython_package pkg do
      runtime runtime
      version ver.to_s
    end
  end
end

def spython_pip_data(runtime)
  pip = node['pip'][runtime]
  raise "No pip binary found for python#{runtime}" unless pip && pip['bin']
  pip
end

def spython_runtime_data(runtime)
  python = node['languages']["python#{runtime}"]
  raise "No python data found for python#{runtime}" unless python && python['bin']
  python
end

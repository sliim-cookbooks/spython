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

property :package, String, name_property: true
property :runtime, String, default: '3'
property :version, String, default: ''
property :venv, String, default: ''

action :install do
  package = new_resource.package
  runtime = new_resource.runtime
  venv = new_resource.venv
  version = new_resource.version
  realversion = version.empty? ? '' : version.match(/([0-9].*)/)[0]
  fullversion = !version.empty? && version.match?(/^[0-9]/) ? "==#{version}" : version
  pip = spython_pip_data(runtime)['packages']

  spython_pip "install #{package}#{fullversion}" do
    runtime runtime
    venv venv
    if venv.empty?
      not_if { (version.empty? && pip.key?(package)) || (!version.empty? && pip.key?(package) && realversion == pip[package]['version']) }
    else
      not_if spython_venv_package_installed_cmd(runtime, venv, package, version)
    end
  end
end

action :upgrade do
  package = new_resource.package
  runtime = new_resource.runtime
  venv = new_resource.venv
  version = new_resource.version
  realversion = version.empty? ? '' : version.match(/([0-9].*)/)[0]
  fullversion = !version.empty? && version.match?(/^[0-9]/) ? "==#{version}" : version
  pip = spython_pip_data(runtime)['packages']

  spython_pip "install --upgrade #{package}#{fullversion}" do
    runtime runtime
    venv venv
    if venv.empty?
      not_if { !version.empty? && pip.key?(package) && realversion == pip[package]['version'] }
    elsif !version.empty?
      not_if spython_venv_package_installed_cmd(runtime, venv, package, version)
    end
  end
end

action :remove do
  package = new_resource.package
  runtime = new_resource.runtime
  venv = new_resource.venv
  pip = spython_pip_data(runtime)['packages']

  spython_pip "uninstall #{package}" do
    runtime runtime
    venv venv
    if venv.empty?
      only_if { pip.key?(package) }
    else
      only_if spython_venv_package_installed_cmd(runtime, venv, package)
    end
  end
end
